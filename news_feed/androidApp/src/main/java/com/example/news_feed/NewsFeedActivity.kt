package com.example.news_feed

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.news_feed.cache.Cache
import com.example.news_feed.cache.NewsInMemoryCache
import com.example.news_feed.cache.NewsNetworkCache
import com.example.news_feed.databinding.ActivityNewsFeedBinding
import com.example.news_feed.model.entity.NewsEntity
import com.example.news_feed.model.source.FirebaseNewsStorage
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext


class NewsFeedActivity : AppCompatActivity() {
    // Replace findViewById() calls with view binding
    // to provide compile-time type safety for code that interacts with views.
    private lateinit var newsFeedBinding: ActivityNewsFeedBinding
    private val scope = CoroutineScope(Dispatchers.Main)

    private var isLoading = false
    private var isLastPage = false
    var currentPage = 0

    var newsList: List<NewsEntity> = ArrayList()

    //private val newsSource = FirebaseNewsStorage(Firebase.firestore)

    private val adapter = NewsAdapter(newsList.toMutableList(), this)
    private var cache: Cache<Int, List<NewsEntity>>? = null

    suspend fun doApiCall() {
        cache?.let {
            val list = withContext(Dispatchers.IO) { it.get(currentPage) }
            if (list != null) {
                newsList = list
            } else {
                isLastPage = true
            }
        }
        adapter.addItems(newsList)

        cache?.get(currentPage + 1)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        newsFeedBinding = ActivityNewsFeedBinding.inflate(layoutInflater)
        val view = newsFeedBinding.root
        setContentView(view)
        val activity = this

        //Add refresh action
        newsFeedBinding.swipeRefresh.setOnRefreshListener {
            newsFeedBinding.swipeRefresh.isRefreshing = false
            onRefresh()
        }

        // Init caches
        cache = NewsInMemoryCache().compose(NewsNetworkCache(NewsPaginationListener.PAGE_SIZE))

        newsFeedBinding.newsRecyclerView.apply {
            var linearLayoutManager = LinearLayoutManager(activity)
            layoutManager = linearLayoutManager
            addOnScrollListener(
                object: NewsPaginationListener(linearLayoutManager) {
                    override fun loadMoreItems() {
                        isLoading = true
                        currentPage++
                        scope.launch(Dispatchers.Main) {
                            doApiCall()
                            isLoading = false
                        }
                    }

                    override fun isLastPage(): Boolean {
                        return isLastPage
                    }

                    override fun isLoading(): Boolean {
                        return isLoading
                    }

                }
            )
        }
        scope.launch(Dispatchers.Main) {
            doApiCall()
            newsFeedBinding.newsRecyclerView.adapter = adapter
        }
    }

    fun onRefresh() {
        currentPage = NewsPaginationListener.PAGE_START;
        isLastPage = false;
        adapter.clear();
        scope.launch(Dispatchers.Main) {
            doApiCall();
        }
    }
}
