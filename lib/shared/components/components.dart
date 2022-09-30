import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/webview/webview_screen.dart';
import 'package:news/shared/cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required TextInputType inputType,
  required String? Function(String? value) validate,
  required IconData? prefixIcon,
  Color? prefixIconColor,
  Color? labelColor,
  Color? enabledBorderColor,
  Color? textInputColor,
  double? borderRaduis,
  VoidCallback? onTap,
  Function(String)? onChange,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  Function(String)? onSubmit,
  bool isPassword = false,
}) =>
    TextFormField(
      style: TextStyle(
        color: textInputColor,
      ),
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRaduis!)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaduis),
          borderSide: BorderSide(
            color: enabledBorderColor!,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        ),
      ),
      keyboardType: inputType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
    );

Widget buildArticleItem(article, context) => InkWell(
    onTap:(){
    navigateTo(context, WebviewScreen(article['url']));
  } ,
    child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: article['urlToImage'] != null
                        ? NetworkImage("${article['urlToImage']}")
                        : const AssetImage('assets/images/News.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 12,
            ),
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
                        style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: NewsCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
);

Widget articleBuilder(list, context) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
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

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
