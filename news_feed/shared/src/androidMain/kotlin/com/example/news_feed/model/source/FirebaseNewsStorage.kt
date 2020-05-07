package com.example.news_feed.model.source

import com.example.news_feed.model.NewsFeedApi
import com.example.news_feed.model.entity.NewsEntity
import com.google.firebase.Timestamp
import java.text.SimpleDateFormat
import com.google.firebase.firestore.*
import com.soywiz.klock.Date
import com.soywiz.klock.DateTime
import kotlinx.coroutines.tasks.await


actual class FirebaseNewsStorage(var db: FirebaseFirestore) :
    NewsFeedApi {

    private fun newsCollection() = db.collection("news")

    override suspend fun getNews(offset: Int, count: Int): List<NewsEntity> {
        val result = newsCollection()
            .orderBy("id")
            .startAt(offset)
            .limit(count.toLong())
            .get()
            .await()

        return result.map { x -> buildNewsEntity(x) }

    }

    private fun buildNewsEntity(x: QueryDocumentSnapshot): NewsEntity {
        val timestamp = x["published"] as Timestamp

        return NewsEntity(
            id = x["id"] as Long,
            title = x["title"] as String,
            image_url = x["image_url"] as String,
            description = x["description"] as String,
            published = DateTime.fromUnix(timestamp.seconds),
            news_url = x["news_url"] as String
        )
    }
}