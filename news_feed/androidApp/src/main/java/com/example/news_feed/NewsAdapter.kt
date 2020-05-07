package com.example.news_feed

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.GlideBuilder
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.load.engine.cache.DiskCache
import com.example.news_feed.databinding.NewsObjectBinding
import com.example.news_feed.model.entity.NewsEntity
import kotlinx.android.synthetic.main.news_object.view.*
import java.text.SimpleDateFormat
import java.util.concurrent.ThreadPoolExecutor


class NewsAdapter(private var news: MutableList<NewsEntity>, val context: Context) :
    RecyclerView.Adapter<NewsAdapter.ViewHolder>() {

    private lateinit var newsObjectBinding: NewsObjectBinding

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        private val newsDescription: TextView = view.news_text_description
        private val newsTitle: TextView = view.news_title
        private val publishedDate: TextView = view.news_published_date
        private val newsImageView: ImageView = view.news_image_view

        private val dateFormat = "dd MMMM"

        fun bind(news: NewsEntity, context: Context) {
            val shortDescription = if (news.description.length > 100) {
                news.description.substring(
                    0,
                    news.description.indexOf(' ', 100)
                ) + "..."
            } else {
                news.description
            }

            newsTitle.text = news.title
            newsDescription.text = shortDescription
            publishedDate.text = news.published.format(dateFormat)


            Glide.with(context)
                .load(news.image_url)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .into(newsImageView)

            this.newsImageView.setOnClickListener {
                val openURL = Intent(Intent.ACTION_VIEW)
                openURL.data = Uri.parse(news.news_url)
                context.startActivity(openURL)
            }
        }
    }

    fun addItems(items: List<NewsEntity>)
    {
        this.news.plusAssign(items)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater =  LayoutInflater.from(parent.context) //LayoutInflater.from(context)
        newsObjectBinding = NewsObjectBinding.inflate(inflater, parent, false) //.inflate(inflater)

        return ViewHolder(newsObjectBinding.root.rootView)
    }

    override fun getItemCount(): Int {
        return news.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = news[position]

        holder.bind(item, context)
    }

    fun clear() {
        news.clear()
        notifyDataSetChanged()
    }

}

