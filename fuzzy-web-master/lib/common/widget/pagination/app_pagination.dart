import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:gap/gap.dart';

class AppPagination extends StatefulWidget {
  final int pageTotal;
  final int pageInit;
  final ValueChanged<int> onPageChanged;
  const AppPagination({super.key, required this.pageTotal, required this.pageInit, required this.onPageChanged});

  @override
  State<AppPagination> createState() => _AppPaginationState();
}

class _AppPaginationState extends State<AppPagination> {
  int activePage = 1;
  List<int> pageOnList = [];
  int showpage = 5;
  int berearPage = 0;
  int lastNumber = 5;

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      setState(() {
        if (widget.pageTotal != pageOnList.length) {
          pageOnList = List.generate(widget.pageTotal, (index) => index + 1);
          activePage = widget.pageInit;
          showpage = widget.pageTotal > 5 ? 5 : widget.pageTotal;
          lastNumber = showpage;
          berearPage = 0;
        }
      });
    }

    if (pageOnList.length > 1) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (berearPage > 0) {
                  setState(() {
                    berearPage--;
                    lastNumber--;
                  });
                }
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 24,
                color: berearPage == 0 ? Colors.grey : AppColors.blue.secondary,
              ),
            ),
            const Gap(10),
            for (int i = 0; i < showpage; i++)
              InkWell(
                onTap: () {
                  setState(() {
                    activePage = pageOnList[i + berearPage];
                    widget.onPageChanged(activePage);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7.5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: activePage == pageOnList[i + berearPage] ? AppColors.blue.secondary : Colors.transparent,
                  ),
                  child: Text(
                    '${pageOnList[i + berearPage]}',
                    style: AppTextStyle.s16w600(color: activePage == pageOnList[i + berearPage] ? AppColors.white.text : AppColors.black.text),
                  ),
                ),
              ),
            const Gap(10),
            InkWell(
              onTap: () {
                if ((showpage + berearPage) < pageOnList.length) {
                  setState(() {
                    berearPage++;
                    lastNumber++;
                    debugPrint('showpage $showpage, bearerpage $berearPage, pageOnList.length: ${pageOnList.length}');
                  });
                }
              },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: (showpage + berearPage) < pageOnList.length ? AppColors.blue.primary : Colors.grey,
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
