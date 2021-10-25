import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/searchModel.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/constants/constants.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var searchController=TextEditingController();
    return BlocProvider(create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(title: Text('Search'),),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    formFeild(
                        label: 'Search',
                        hint: 'Search',
                        prefix: Icons.search,
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Invalid Search';
                          }
                        },
                        isPassword: false,
                      onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                      }
                    ),
                   SizedBox(height: 5,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                      Expanded(child:ListView.separated(
                          itemBuilder:(context,index)=>buildSearchItem(model: SearchCubit.get(context).model,index: index),
                          separatorBuilder: (context,index)=>myDivider(),
                          itemCount: SearchCubit.get(context).model.data.data.length
                      ),),
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }

  Widget buildSearchItem({SearchModel model,int index})=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10,),
      Container(
        child:
        Image(
          image: NetworkImage(model.data.data[index].image),
          width: double.infinity,
          height: 200,
        ),
        color: Colors.white,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.data.data[index].name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.1),
            ),
            Row(
              children: [
                Text(
                  'Price ${model.data.data[index].price} \$',
                  style: TextStyle(color: defultColor),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    ],
  );
}
