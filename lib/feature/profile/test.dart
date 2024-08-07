// import 'package:flutter/material.dart';
//
// class Test extends StatelessWidget {
//   const Test({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         Align(
//           alignment: const AlignmentDirectional(0, 0),
//           child: Stack(
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(0, -1.17),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(0),
//                   child: Image.network(
//                     'https://picsum.photos/seed/303/600',
//                     width: 465,
//                     height: 290,
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: const AlignmentDirectional(0, 0),
//                 child: ListView(
//                   children: [
//                     Container(
//                       width: 468,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFEB0000),
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(0),
//                           bottomRight: Radius.circular(0),
//                           topLeft: Radius.circular(50),
//                           topRight: Radius.circular(50),
//                         ),
//                         shape: BoxShape.rectangle,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 600,
//                               color: Colors.yellow,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: const AlignmentDirectional(0, -0.66),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(50),
//                       child: Image.network(
//                         'https://picsum.photos/seed/319/600',
//                         width: 101,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const Text(
//                       'Hello World',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/widget/custtom_widget/app_text.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
          size: 30,
        ),
        title: const Text(
          'Profile',
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: ListView(
          children: [
            SizedBox(
              height: 290.h,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://source.unsplash.com/random/1280x720?profile&52',
                        width: double.infinity,
                        height: 220.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 1),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: const CircleBorder(),
                      child: Container(
                        width: 130.w,
                        height: 130.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3.w,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4).w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50).r,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                              width: 200.w,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  'Jennifer Cambell',
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'jennifer.cambell@domain.com',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF1F4F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              '1,602',
                            ),
                          ),
                          Text(
                            'Item Saves',
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                            child: Text(
                              '420',
                            ),
                          ),
                          Text(
                            'Followers',
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                            child: Text(
                              '15,200',
                            ),
                          ),
                          Text(
                            'Item Views',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    text: 'Posts',
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: 140.w,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'All',
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text: 'Photos',
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          text: 'Videos',
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://source.unsplash.com/random/1280x720?profile&55',
                      width: 190.w,
                      height: 230.h,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.red,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
