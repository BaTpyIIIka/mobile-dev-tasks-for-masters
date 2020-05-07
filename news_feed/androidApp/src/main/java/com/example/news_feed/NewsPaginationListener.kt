package com.example.news_feed

import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

abstract class NewsPaginationListener(private val linearLayoutManager: LinearLayoutManager)
    : RecyclerView.OnScrollListener() {

    override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
        super.onScrolled(recyclerView, dx, dy)

        val visibleItemCount = linearLayoutManager.childCount
        val totalItemCount = linearLayoutManager.itemCount
        val firstVisibleItemPosition = linearLayoutManager.findFirstVisibleItemPosition()

        if (!isLoading() && !isLastPage()) {
            if ((visibleItemCount + firstVisibleItemPosition) >= totalItemCount
                && firstVisibleItemPosition >= 0
                && totalItemCount >= PAGE_SIZE
            ) {
                loadMoreItems()
            }
        }
    }

    abstract fun loadMoreItems()
    abstract fun isLastPage() : Boolean
    abstract fun isLoading() : Boolean

    companion object {
        const val PAGE_SIZE = 5
        const val PAGE_START = 0
    }
}