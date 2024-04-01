import 'package:flutter/material.dart';

import 'constants/myWidgets.dart';
import 'constants/my_colors.dart';

class BuynowScreen extends StatelessWidget {
  const BuynowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Container(
      width: width,
      height: height,
      child: Stack(children: [
        Container(
          height: height / 1.68567,
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image 22 (1).png"),
                  fit: BoxFit.fill)),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(children: [
                Container(
                    padding: EdgeInsets.only(
                        left: width / 21.66666666666667,
                        right: width / 21.66666666666667,
                        top: width / 26.375),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26)),
                      color: cl1B4341,
                    ),
                    child: Column(children: <Widget>[
                      SizedBox(
                        width: width / 1.287128712871287,
                        child: Text(
                          "കെ എം സീതിസാഹിബ് കരുത്തനായ കർമയോഗി",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: clWhite,
                              fontFamily: "PoppinsRegular",
                              fontSize: width / 24.375,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'By Jane Austen',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: ' PoppinsRegular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 38,
                            width: 86,
                            decoration: BoxDecoration(
                                color: cl153332,
                                borderRadius: BorderRadius.circular(51)),
                            child: const Text(
                              '₹ 1,500',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Robbo",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 38,
                            width: 98,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/Frame 404 (1).png"))),
                            child: const Text(
                              "Best Sellers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(" Free Delivery",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Price Include GST',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(children: [
                            Icon(
                              Icons.lock,
                              color: clE8AD14,
                            ),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                  color: clWhite,
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                          const Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: clWhite,
                              ),
                              Text(
                                'Favorite',
                                style: TextStyle(
                                    color: clWhite,
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 38,
                            width: 86,
                            decoration: BoxDecoration(
                              color: clE8AD14,
                              borderRadius: BorderRadius.circular(54),
                            ),
                            child: const Text(
                              'But Now',
                              style: TextStyle(
                                color: cl303030,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 20.0,
                        thickness: 1,
                        color: cl5F5F5F,
                        indent: 1.5,
                        endIndent: 25.0,
                      ),
                      SizedBox(height: 15),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 364,
                              height: 151,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                        color: clCBCBCB,
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                      'Lorem ipsum dolor sit amet consectetur.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' Tristique vel fermentum egestas augue.Nibh',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' nisi mattis sed vulputate egestas neque at',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' orci. Diam cursus est nunc amet tellus.',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' Eleifend nisl non auctor pulvinar in id.Amet',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(' euismod at sollicitudin purus diam eu',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 364,
                              height: 161,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Book Overview',
                                    style: TextStyle(
                                        color: clCBCBCB,
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                      'Lorem ipsum dolor sit amet consectetur.',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' Tristique vel fermentum egestas augue.Nibh',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' nisi mattis sed vulputate egestas neque at',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' orci. Diam cursus est nunc amet tellus.',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      ' Eleifend nisl non auctor pulvinar in id.Amet',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  Text(' euismod at sollicitudin purus diam eu',
                                      style: TextStyle(
                                          color: clCBCBCB,
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ]),
                      Container(
                        height: 197,
                        width: 374,
                        decoration: BoxDecoration(
                          color: cl153332,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "About The Book",
                                  style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Print Length ',
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    "150 Pages",
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Language ',
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    "Malayalam",
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Publisher ',
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    "Grace Book",
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Publication date',
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    "12/12/2000",
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Dimensions',
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    "160*160",
                                    style: TextStyle(
                                      color: clCBCBCB,
                                      fontFamily: "PoppinsRegular",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          "Author Name",
                          style: TextStyle(
                            color: clCBCBCB,
                            fontFamily: "PoppinsRegular",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Al Yaser Ameen',
                              style: TextStyle(
                                  color: clCBCBCB,
                                  fontFamily: "Poppins",
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ])),
                Container(
                    padding: EdgeInsets.only(
                      left: width / 21.66666666666667,
                      right: width / 21.66666666666667,
                    ),
                    // height: 436,
                    width: width,
                    color: Colors.white,
                    child: Column(children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Suggestions for you ",
                              style: TextStyle(
                                color: cl1B4341,
                                fontFamily: "PoppinsRegular",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              // height: 284,
                              // width: 258,
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 107,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 12,
                                    crossAxisCount: 4,
                                  ),
                                  itemCount: 8,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        height: 130,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: clCDCDCD,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ));
                                  }),
                            ),
                          ]),
                      const SizedBox(
                        height: 55,
                      ),
                      Container(
                          height: 154,
                          width: 376,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/Frame 466.png",
                                ),
                                fit: BoxFit.fill),
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Categories",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 9,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 69,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12.0,
                                        mainAxisSpacing: 12.0,
                                        childAspectRatio: 1),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 111,
                                    height: 63,
                                    decoration: BoxDecoration(
                                        color: index < 3 || index >= 6
                                            ? clAFD6D4
                                            : clAFBCD6,
                                        borderRadius: BorderRadius.circular(15),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/categoryBg.png"))),
                                    child: Text(
                                      "Books",
                                      style: TextStyle(
                                        color: clBlack,
                                        fontFamily: "PoppinsRegular",
                                        fontSize: width / 39,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  );
                                }),
                          ])
                    ])
                ),
                SizedBox(height: 40)
              ]),
            );
          },
        ),
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: height / 7.672727272727273,
            color: cl1B4341,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: height / 84.4),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 70,
              scrolledUnderElevation: 0,
              leading: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: clWhite,
                    ),
                    CircleAvatar(
                      backgroundColor: clWhite,
                      radius: 17,
                      child: Icon(
                        Icons.grid_view,
                        color: cl1A3F3D,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              title: Image.asset(
                "assets/logo.png",
                scale: 2,
              ),
              centerTitle: true,
              actions: [
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ], color: clF7F7F7.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(
                    Icons.favorite,
                    color: clE8AD14,
                    size: 15,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ], color: clF7F7F7.withOpacity(0.2), shape: BoxShape.circle),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}
