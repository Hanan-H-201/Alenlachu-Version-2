

import 'package:app/controllers/common/awareness/awareness_cubit.dart';
import 'package:app/models/common/awareness_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/common/awareness/awareness_state.dart';
import '../../../../core/theme/app_theme.dart';
import 'awareness_card.dart';

class AwarenessList extends StatefulWidget {
  const AwarenessList({super.key});

  @override
  State<AwarenessList> createState() => _AwarenessListState();
}

class _AwarenessListState extends State<AwarenessList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.42,
      child: BlocBuilder<AwarenessCubit, AwarenessState>(
  builder: (context, state) {
    if(state is AwarenessLoaded){
      if(state.awarenesses.isEmpty){
        return Center(
          child: Column(
            children: [
              Image.asset('assets/images/empty.png',height: 200,),
              Text('No Articles', style: appTheme.textTheme.bodySmall,)
            ],
          ),
        );
      }else{
        return ListView.builder(scrollDirection: Axis.horizontal,itemCount: state.awarenesses.length, itemBuilder: (context, index) {
          final AwarenessModel awareness = state.awarenesses[index];
          return Row(
            children: [
              AwarenessCard(awareness: awareness),
              const SizedBox(
                width: 20,
              )
            ],
          );
        },);
      }
    }else if(state is AwarenessLoading){
      return Center(
        child: CircularProgressIndicator(
          color: appTheme.primaryColor,
        ),
      );
    }else if(state is AwarenessOperationError){
      return Center(
        child: Text(state.error),
      );
    }else {
      return const Center(
        child: Text('Unknown error occurred'),
      );
    }

  },
),
    );
  }
}
