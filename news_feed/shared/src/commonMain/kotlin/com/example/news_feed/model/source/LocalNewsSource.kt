package com.example.news_feed.model.source

import com.example.news_feed.model.NewsFeedApi
import com.example.news_feed.model.entity.NewsEntity
import com.soywiz.klock.DateTime


class LocalNewsSource(count: Int) : NewsFeedApi {
    private val newsStorage: List<NewsEntity> = (1..count).map { i ->
        NewsEntity(
            id = i.toLong(),
            title = "Title $i",
            image_url = "Image $i",
            description = "Description $i",
            published = DateTime.now(),
            news_url = "URL $i"
        )
    }.toList()

    override suspend fun getNews(offset: Int, count: Int): List<NewsEntity> {
        return newsStorage.drop(offset).take(count).toList()
    }
}