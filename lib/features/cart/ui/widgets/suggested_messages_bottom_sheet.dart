import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

class SuggestedMessagesBottomSheet extends StatefulWidget {
  final List<String> messages;
  final List<String> occassions;
  final Function(String message) onMessageSelected;

  const SuggestedMessagesBottomSheet({
    super.key,
    required this.onMessageSelected,
    this.messages = const [],
    this.occassions = const [],
  });

  @override
  State<SuggestedMessagesBottomSheet> createState() =>
      _SuggestedMessagesBottomSheetState();
}

class _SuggestedMessagesBottomSheetState
    extends State<SuggestedMessagesBottomSheet> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Make sure there's at least one tab
    _tabController = TabController(
      length: widget.occassions.isEmpty ? 1 : widget.occassions.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0.h),
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        appBar: AppBar(
          backgroundColor: ColorsManager.white,
          title: Text(
            context.el.customizeGiftCard,
            style: GoogleFonts.inter(
              color: ColorsManager.mainRose,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.mainRose,
              size: 18.0.h,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          bottom: widget.occassions.isEmpty
              ? null
              : TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: ColorsManager.mainRose,
                  labelColor: ColorsManager.mainRose,
                  unselectedLabelColor: ColorsManager.lighterLightGrey,
                  dividerColor: ColorsManager.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0.sp,
                  ),
                  tabs: widget.occassions
                      .map((category) => Tab(text: category))
                      .toList(),
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),
              Expanded(
                child: widget.occassions.isEmpty
                    ? _buildSimpleMessageList(widget.messages)
                    : TabBarView(
                        controller: _tabController,
                        children: widget.occassions.map((occasion) {
                          // Each tab gets its own list of messages
                          return _buildMessageList(widget.messages);
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleMessageList(List<String> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessageItem(messages[index]);
      },
    );
  }

  Widget _buildMessageList(List<String> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageItem(message);
      },
    );
  }

  Widget _buildMessageItem(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsManager.lightLighterGrey,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.w,
            vertical: 8.0.h,
          ),
          child: InkWell(
            onTap: () {
              widget.onMessageSelected(message);
              Navigator.pop(context); // Close the bottom sheet
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: Text(
                message,
                style: GoogleFonts.inter(
                  color: ColorsManager.black,
                  fontSize: 14.0.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
