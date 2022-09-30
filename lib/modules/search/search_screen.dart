import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  label: "Search",
                  inputType: TextInputType.text,
                  validate: (String? value){
                    if(value!.isEmpty){
                        return 'search cannot be empty';
                      }
                    return null;
                    },
                  onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                  },
                  prefixIcon: Icons.search,
                  prefixIconColor: Colors.grey,
                  labelColor: Colors.grey,
                  enabledBorderColor: Colors.grey,
                  textInputColor: cubit.isDark ? Colors.white : Colors.black,
                  borderRaduis: 15,
                ),
              ),
              Expanded(
                  child: articleBuilder(list, context)
              ),
            ],
          ),
        );
      },
    );
  }
}
