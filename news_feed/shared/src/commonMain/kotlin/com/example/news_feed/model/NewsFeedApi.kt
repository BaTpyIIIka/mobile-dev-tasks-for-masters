package com.example.news_feed.model

import com.example.news_feed.model.entity.NewsEntity

interface NewsFeedApi {
    suspend fun getNews(offset: Int, count: Int): List<NewsEntity>
}