package com.example.news_feed.model.entity

import com.soywiz.klock.DateTime


data class NewsEntity(
    val id: Long,
    val title: String,
    val image_url: String,
    val description: String,
    val published: DateTime,
    val news_url: String
)