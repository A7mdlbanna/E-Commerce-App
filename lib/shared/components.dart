// import 'package:auto_direction/auto_direction.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:shop_app/shared/cubit/app_theme_cubit.dart';
// import 'cubit/cubit.dart';
//
// Widget articleBuilder(category, context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
//     child: InkWell(
//       // onTap: () => AppCubit.get(context).urlLauncher(category),
//       child: Container(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: ThemeCubit.get(context).isDark
//                   ? Colors.black
//                   : Colors.grey.shade400,
//               spreadRadius: 0.2,
//               blurStyle: BlurStyle.outer,
//               blurRadius: 10.0)
//         ], borderRadius: BorderRadius.circular(10.0)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (category['urlToImage'] != null)
//               Image(image: NetworkImage(category["urlToImage"])),
//             SizedBox(
//               height: 15,
//             ),
//             if (category["title"] != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18.0,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: AppCubit.get(context).choosed == 'AE' ||
//                           AppCubit.get(context).choosed == 'EG' ||
//                           AppCubit.get(context).choosed == 'MA' ||
//                           AppCubit.get(context).choosed == 'SA'
//                       ? MainAxisAlignment.start
//                       : MainAxisAlignment.end,
//                   crossAxisAlignment: AppCubit.get(context).choosed == 'AE' ||
//                           AppCubit.get(context).choosed == 'EG' ||
//                           AppCubit.get(context).choosed == 'MA' ||
//                           AppCubit.get(context).choosed == 'SA'
//                       ? CrossAxisAlignment.start
//                       : CrossAxisAlignment.end,
//                   textDirection: AppCubit.get(context).choosed == 'AE' ||
//                           AppCubit.get(context).choosed == 'EG' ||
//                           AppCubit.get(context).choosed == 'MA' ||
//                           AppCubit.get(context).choosed == 'SA'
//                       ? TextDirection.rtl
//                       : TextDirection.ltr,
//                   children: [
//                     Text(
//                       category["title"],
//                       style: Theme.of(context).textTheme.headline1,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 3,
//                     ),
//                   ],
//                 ),
//               ),
//             if (category["description"] != null)
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
//                 child: Text(
//                   category['description'],
//                   style: Theme.of(context).textTheme.headline2,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(category["source"]["name"] ?? '',
//                       style: Theme.of(context).textTheme.bodyText1),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   if (category["source"]["name"] != '' &&
//                       AppCubit.get(context).duration(category) != '')
//                     ImageIcon(
//                       AssetImage('assets/dot.png'),
//                       size: 4.5,
//                       color: Colors.grey.shade700,
//                     ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(AppCubit.get(context).duration(category) ?? '',
//                       style: Theme.of(context).textTheme.bodyText2),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// Widget searchItemBuilder(context, category) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
//     child: InkWell(
//       onTap: () => AppCubit.get(context).urlLauncher(category),
//       child: Container(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: ThemeCubit.get(context).isDark
//                   ? Colors.black
//                   : Colors.grey.shade400,
//               spreadRadius: 0.1,
//               blurStyle: BlurStyle.outer,
//               blurRadius: 10.0)
//         ], borderRadius: BorderRadius.circular(10.0)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
//                 child: Row(
//                   children: [
//                     // if (category["title"] != null)
//                       Container(
//                         child: Expanded(
//                           child: Text(
//                             category["title"],
//                             style: Theme.of(context).textTheme.headline3,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 5,
//                           ),
//                         ),
//                       ),
//                     SizedBox(width: 10,),
//                     if (category['urlToImage'] != null)Expanded(child: Image(image: NetworkImage(category["urlToImage"]), height: 100, width: 100,)),
//                   ],
//                 ),
//               ),
//             ),
//             if (category["description"] != null)Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Text(
//                   category['description'],
//                   style: Theme.of(context).textTheme.headline2,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               ),
//             SizedBox(height: 5,),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Text(category["source"]["name"] ?? '',
//                   style: Theme.of(context).textTheme.bodyText1),
//             ),
//             SizedBox(height: 10,)
//           ],
//         ),
//       ),
//     ),
//   );
// }
