package com.example.news_feed.cache

import com.example.news_feed.model.entity.NewsEntity
import com.example.news_feed.model.source.FirebaseNewsStorage
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class NewsNetworkCache(private val pageSize: Int) : Cache<Int, List<NewsEntity>> {

    private val newsSource = FirebaseNewsStorage(Firebase.firestore)

    override suspend fun get(key: Int): List<NewsEntity>? {
        return newsSource.getNews(key * pageSize, pageSize)
    }

    override suspend fun set(key: Int, value: List<NewsEntity>) {

    }
}