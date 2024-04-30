import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/services/api_service.dart';
import 'package:running_app/utils/common_widgets/icon_button.dart';
import 'package:running_app/utils/common_widgets/limit_text_line.dart';
import 'package:running_app/utils/common_widgets/main_wrapper.dart';
import 'package:running_app/utils/common_widgets/separate_bar.dart';
import 'package:running_app/utils/common_widgets/show_action_list.dart';
import 'package:running_app/utils/common_widgets/show_user_list.dart';
import 'package:running_app/utils/common_widgets/show_month_year.dart';
import 'package:running_app/utils/common_widgets/show_notification.dart';
import 'package:running_app/utils/common_widgets/text_button.dart';
import 'package:running_app/utils/constants.dart';
import 'package:running_app/utils/function.dart';


class PostWidget extends StatefulWidget {
  final String token;
  final dynamic post;
  final bool? checkRequestUser;
  final bool socialSection;
  final bool detail;
  final String postType;
  final String postTypeId;
  final bool like;
  final VoidCallback deleteOnPressed;
  final VoidCallback editOnPressed;
  final VoidCallback likeOnPressed;

  const PostWidget({
    required this.token,
    required this.post,
    required this.postType,
    required this.postTypeId,
    required this.like,
    required this.deleteOnPressed,
    required this.editOnPressed,
    required this.likeOnPressed,
    this.checkRequestUser,
    this.socialSection = true,
    this.detail = false,
    super.key
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool showFullTitle = false;
  bool showFullDescription = false;
  bool showViewMoreDescriptionButton = false;
  bool showViewMoreTitleButton = false;
  int currentSlide = 0;
  Map<String, dynamic> popArguments = {};

  @override
  void initState() {
    super.initState();
  }

  void postDetailRedirect() {
    Navigator.pushNamed(context, '/post_detail', arguments: {
      "id": widget.post?.id,
      "checkRequestUser": widget.checkRequestUser,
      "postType": widget.postType,
      "postTypeId": widget.postTypeId,
    });
  }

  @override
  Widget build(BuildContext context) {
    bool like = widget.like;
    var media = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: media.height * 0.01,),
        //User section
        MainWrapper(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user', arguments: {
                    "id": widget.post?.user?.id,
                  });
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/img/community/ptit_logo.png",
                        width: 45,
                        height: 45,
                      ),
                    ),
                    SizedBox(width: media.width * 0.02,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: media.width * 0.75,
                          child: Text(
                            '${widget.post?.user?.name ?? ""}',
                            style: TxtStyle.headSection,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${formatDateTimeEnUS(DateTime.parse(widget.post?.createdAt ?? ""), timeFirst: true, time: true)}',
                              style: TxtStyle.descSection,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              if(widget.checkRequestUser == true)...[
                CustomIconButton(
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: TColor.PRIMARY_TEXT,
                  ),
                  onPressed: () {
                    showActionList(
                        context,
                        [
                          {
                            "text": "Edit post",
                            "onPressed": widget.editOnPressed
                          },
                          {
                            "text": "Delete post",
                            "textColor": Colors.red,
                            "onPressed": widget.deleteOnPressed
                          }
                        ],
                        "Options");
                  },
                )
              ]
            ],
          ),
        ),
        SizedBox(height: media.height * 0.01,),

        // Caption section
        MainWrapper(
          topMargin: 0,
          child: GestureDetector(
            onTap: (widget.detail == false) ? () {
              postDetailRedirect();
            } : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.post?.title != "")...[
                  LimitTextLine(
                    showFullText: showFullTitle,
                    showViewMoreButton: showViewMoreTitleButton,
                    description: '${widget.post?.title}',
                    onTap: () {
                      setState(() {
                        showFullTitle = (showFullTitle) ? false : true;
                      });
                    },
                    style: TextStyle(
                        color: TColor.PRIMARY_TEXT,
                        fontSize: FontSize.LARGE,
                        fontWeight: FontWeight.w600
                    ),
                    charInLine: 35,
                  ),
                  SizedBox(height: media.height * 0.01,),
                ],
                if(widget.post?.content != "")...[
                  LimitTextLine(
                    showFullText: showFullDescription,
                    showViewMoreButton: showViewMoreDescriptionButton,
                    description: "${widget.post?.content}",
                    onTap: () {
                      setState(() {
                        showFullDescription = (showFullDescription) ? false : true;
                      });
                    },
                  ),
                  SizedBox(height: media.height * 0.01,),
                ]
              ],
            ),
          ),
        ),
        SizedBox(height: media.height * 0.005,),

        // Image section
        Column(
          children: [
            GestureDetector(
              onTap: (widget.detail == false) ? () {
                postDetailRedirect();
              } : null,
              child: SizedBox(
                height: media.height * 0.27,
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 1
                  ),
                  items: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/img/community/ptit_background.jpg",
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: media.height * 0.01,),
            DotsIndicator(
              dotsCount: 10,
              position: currentSlide,
              decorator: DotsDecorator(
                activeColor: TColor.PRIMARY,
                spacing: const EdgeInsets.only(left: 8),
              ),
            )
          ],
        ),

        // Social section
        if(widget.socialSection)...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if(widget.detail == false)...[
                MainWrapper(
                  // topMargin: 0,
                  child: Container(
                    width: media.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showUserList(
                              context,
                              widget.post.likes ?? [] ,
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: TColor.THIRD,
                                  ),
                                  SizedBox(width: media.width * 0.01,),
                                  if(like == true)...[
                                    Text(
                                      "${widget.post.totalLikes}",
                                      style: TxtStyle.normalTextDesc,
                                    ),
                                  ]
                                  else...[
                                    Text(
                                      "${widget.post.totalLikes}",
                                      style: TxtStyle.normalTextDesc,
                                    )
                                  ]
                                ],
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: TColor.THIRD,
                              ),
                              SizedBox(width: media.width * 0.01,),
                              Text(
                                "${widget.post.totalLikes}",
                                style: TxtStyle.normalTextDesc,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Map<String, dynamic> x = await Navigator.pushNamed(context, '/post_detail', arguments: {
                              "id": widget.post.id,
                              "checkRequestUser": widget.checkRequestUser,
                              "postType": widget.postType,
                              "postTypeId": widget.postTypeId,
                            }) as Map<String, dynamic>;
                            setState(() {
                              popArguments = x;
                            });
                          },
                          child: Text(
                            "${popArguments["totalComments"] ?? widget.post.totalComments} comment",
                            style: TxtStyle.normalTextDesc,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: media.height * 0.015,),

              if(widget.detail == false)...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: TColor.BORDER_COLOR),
                          bottom: BorderSide(width: 1, color: TColor.BORDER_COLOR)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceAround,
                    children: [
                      for(var x in [
                        {
                          "icon": (like)
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          "text": "Like",
                          "onPressed": widget.likeOnPressed
                        },
                        {
                          "icon": Icons.mode_comment_outlined,
                          "text": "Comment",
                          "onPressed": () {
                            if(widget.detail == false) {
                              postDetailRedirect();
                            }
                          }
                        },
                        (widget.checkRequestUser == true) ? {
                          "icon": Icons.ios_share_rounded,
                          "text": "Share",
                          "onPressed": () {}
                        } : null,
                      ])...[
                        if(x != null)...[
                          CustomTextButton(
                            onPressed: x["onPressed"] as VoidCallback,
                            child: Row(
                              children: [
                                Icon(
                                  x["icon"] as IconData,
                                  color: (like && x["text"] == "Like")
                                      ? TColor.THIRD
                                      : TColor.PRIMARY_TEXT,
                                ),
                                SizedBox(width: media.width * 0.02,),
                                Text(
                                  x["text"] as String,
                                  style: TextStyle(
                                    color: (like && x["text"] == "Like")
                                        ? TColor.THIRD
                                        : TColor.PRIMARY_TEXT,
                                    fontSize: FontSize. NORMAL,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // if(x["text"] != "Share") SeparateBar(width: 1, height: 45, color: TColor.BORDER_COLOR,)
                        ]
                      ]
                    ],
                  ),
                ),
              ]

              // if(widget.detail == true)...[
              //   MainWrapper(
              //     topMargin: 0,
              //     child: CustomTextButton(
              //       style: ButtonStyle(
              //           padding: MaterialStateProperty.all(EdgeInsets.all(0))
              //       ),
              //       onPressed: (widget.detail == false) ? () {
              //         Navigator.pushNamed(context, '/activity_record_detail', arguments: {
              //           "id": widget.post.id,
              //           "checkRequestUser": widget.checkRequestUser,
              //         });
              //       } : null,
              //       child: Container(
              //         width: media.width,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             GestureDetector(
              //               onTap: () {
              //                 showUserList(
              //                   context,
              //                   widget.post.likes ?? [] ,
              //                   title: Row(
              //                     children: [
              //                       Icon(
              //                         Icons.thumb_up,
              //                         color: TColor.THIRD,
              //                       ),
              //                       SizedBox(width: media.width * 0.01,),
              //                       if(like == true)...[
              //                         Text(
              //                           "${widget.post.totalLikes}",
              //                           style: TxtStyle.normalTextDesc,
              //                         ),
              //                       ]
              //                       else...[
              //                         Text(
              //                           "${widget.post.totalLikes}",
              //                           style: TxtStyle.normalTextDesc,
              //                         )
              //                       ]
              //                     ],
              //                   ),
              //                 );
              //               },
              //               child: Row(
              //                 children: [
              //                   Icon(
              //                     Icons.thumb_up,
              //                     color: TColor.THIRD,
              //                   ),
              //                   SizedBox(width: media.width * 0.01,),
              //                   if(like == true)...[
              //                     Text(
              //                       "${widget.post.totalLikes}",
              //                       style: TxtStyle.normalTextDesc,
              //                     ),
              //                   ]
              //                   else...[
              //                     Text(
              //                       "${widget.post.totalLikes}",
              //                       style: TxtStyle.normalTextDesc,
              //                     )
              //                   ]
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ]
            ],
          )
        ]
      ],
    );
  }
}


