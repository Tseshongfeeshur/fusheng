import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

/// 日记假数据模型
class DiaryModel {
  final String id;
  final String time; // 时间如 "14:20"
  final String dateStr; // 日期如 "07/27"
  final String monthHeader; // 月份标头如 "2026年 7月"
  final String moodEmoji; // 心情/天气节点
  final String? title;
  final String content;
  final List<String> tags;
  final String? imageUrl;
  final String location;

  DiaryModel({
    required this.id,
    required this.time,
    required this.dateStr,
    required this.monthHeader,
    required this.moodEmoji,
    this.title,
    required this.content,
    required this.tags,
    this.imageUrl,
    required this.location,
  });
}

class DiaryTimelinePage extends StatefulWidget {
  const DiaryTimelinePage({Key? key}) : super(key: key);

  @override
  State<DiaryTimelinePage> createState() => _DiaryTimelinePageState();
}

class _DiaryTimelinePageState extends State<DiaryTimelinePage> {
  // 假数据列表
  final List<DiaryModel> _diaryList = [
    DiaryModel(
      id: '1',
      time: '22:15',
      dateStr: '07/27',
      monthHeader: '2026年 7月',
      moodEmoji: '🌙',
      title: '深夜的代码与灵感',
      content: '今天把 Flutter 的时间流页面写完了，毛玻璃结合轴线的质感比预想中要好得多。希望这个项目能一直坚持写下去。',
      tags: ['Flutter', '开发', '夜读'],
      location: '山西·大同',
    ),
    DiaryModel(
      id: '2',
      time: '16:40',
      dateStr: '07/25',
      monthHeader: '2026年 7月',
      moodEmoji: '☕',
      title: '下午茶时光',
      content: '尝试了新的深烘咖啡豆，酸质很低，带有很明显的黑巧和坚果香味。顺便把本周的周报整理了一下。',
      tags: ['咖啡', '日常'],
      imageUrl: 'https://picsum.photos/seed/coffee/600/300',
      location: '咖啡馆',
    ),
    DiaryModel(
      id: '3',
      time: '09:10',
      dateStr: '06/18',
      monthHeader: '2026年 6月',
      moodEmoji: '🌧️',
      title: '雨天的钢琴曲',
      content: '窗外下着大雨，在家弹了一会儿德彪西的《月光》。雨声和琴音混在一起的时候，感觉时间都变慢了。',
      tags: ['音乐', '钢琴', '下雨天'],
      location: '家中',
    ),
    DiaryModel(
      id: '4',
      time: '20:30',
      dateStr: '06/01',
      monthHeader: '2026年 6月',
      moodEmoji: '🎮',
      title: '游戏通关纪念',
      content: '终于把这款单机游戏通关了！最后的剧情演出和原声音乐真的绝了，准备写一篇长评记录一下。',
      tags: ['游戏', '通关记录'],
      imageUrl: 'https://picsum.photos/seed/game/600/300',
      location: '书房',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          '时光日志',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: _diaryList.length,
        itemBuilder: (context, index) {
          final item = _diaryList[index];

          // 判断是否需要显示月份 Header
          bool showMonthHeader = false;
          if (index == 0 ||
              _diaryList[index - 1].monthHeader != item.monthHeader) {
            showMonthHeader = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 吸顶/分组月份 Header
              if (showMonthHeader) _buildMonthHeader(item.monthHeader),

              // 2. 时间轴节点项
              TimelineTile(
                isFirst: index == 0,
                isLast: index == _diaryList.length - 1,
                alignment: TimelineAlign.manual,
                lineXY: 0.22, // 轴线靠左 22% 的位置
                beforeLineStyle: LineStyle(
                  color: theme.colorScheme.outlineVariant,
                  thickness: 2,
                ),
                afterLineStyle: LineStyle(
                  color: theme.colorScheme.outlineVariant,
                  thickness: 2,
                ),

                // 轴线上的圆圈/心情节点
                indicatorStyle: IndicatorStyle(
                  width: 36,
                  height: 36,
                  indicator: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        item.moodEmoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),

                // 左侧时间显示 (日期 + 具体时刻)
                startChild: Container(
                  padding: const EdgeInsets.only(right: 12),
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.dateStr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        item.time,
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // 右侧日记主体卡片
                endChild: _buildDiaryCard(context, item),
              ),
            ],
          );
        },
      ),

      // 底部悬浮按钮：极速记日记
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: 打开记日记页面
        },
        icon: const Icon(Icons.edit_outlined),
        label: const Text('记录今天'),
      ),
    );
  }

  /// 构建月份标头
  Widget _buildMonthHeader(String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, bottom: 12),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建右侧日记卡片
  Widget _buildDiaryCard(BuildContext context, DiaryModel item) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 16, 12),
      child: Card(
        elevation: 1.5,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias, // 让图片适应圆角
        child: InkWell(
          onTap: () {
            // TODO: 点击卡片进入日记详情页
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. 标题（如果有）
                if (item.title != null) ...[
                  Text(
                    item.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                // 2. 正文
                Text(
                  item.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: theme.colorScheme.onSurface.withOpacity(0.85),
                  ),
                ),

                // 3. 配图（如果有）
                if (item.imageUrl != null) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl!,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => const SizedBox(),
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // 4. 底部栏：标签 + 地理位置
                Row(
                  children: [
                    // 标签组
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: item.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '#$tag',
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // 地理位置
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          item.location,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
