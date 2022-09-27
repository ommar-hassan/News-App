import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: (article['urlToImage']) != null ? NetworkImage("${article['urlToImage']}") : const AssetImage('assets/images/News.png') as ImageProvider,
              fit: BoxFit.cover,
            )
        ),
      ),
      const SizedBox( width: 12,),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "${article['title']}",
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: const TextStyle(
                    color: Colors.grey
                ),),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildArticleItem(list[index]),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      ),
    ),
    itemCount: list.length,
    physics: const BouncingScrollPhysics(),
  ),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);