import 'package:flutter/material.dart';
import 'package:nextrade/core/common/widgets/my_drawer.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final List<StockMarketTopic> topics = [
    StockMarketTopic(
      title: "Basics of the Stock Market",
      icon: Icons.foundation,
      description: "Learn about stock exchanges, market participants, and how the market works",
      sections: [
        "What is a stock market?",
        "Market participants",
        "Stock exchanges",
        "Market mechanics"
      ],
    ),
    StockMarketTopic(
      title: "Stock Market Instruments",
      icon: Icons.bar_chart,
      description: "Explore different investment vehicles and financial instruments",
      sections: [
        "Equities (Stocks)",
        "Derivatives",
        "Bonds and Fixed-Income",
        "Mutual Funds & ETFs",
        "Commodities & Forex"
      ],
    ),
    StockMarketTopic(
      title: "Fundamental Analysis",
      icon: Icons.analytics,
      description: "Evaluate companies using financial statements and economic factors",
      sections: [
        "Financial Statements",
        "Key Financial Ratios",
        "Accounting Principles",
        "Macroeconomic Factors",
        "Company Valuation Models"
      ],
    ),
    StockMarketTopic(
      title: "Technical Analysis",
      icon: Icons.candlestick_chart,
      description: "Analyze price movements and chart patterns to predict future trends",
      sections: [
        "Chart Patterns",
        "Indicators & Oscillators",
        "Candlestick Patterns",
        "Support & Resistance"
      ],
    ),
    StockMarketTopic(
      title: "Trading Strategies",
      icon: Icons.trending_up,
      description: "Different approaches to trading and investment",
      sections: [
        "Day Trading vs. Swing Trading",
        "Long-term Investing",
        "Options Trading Strategies"
      ],
    ),
    StockMarketTopic(
      title: "Market Psychology",
      icon: Icons.psychology,
      description: "Understanding investor behavior and market sentiment",
      sections: [
        "Fear and Greed",
        "Common Biases",
        "Behavioral Finance"
      ],
    ),
    StockMarketTopic(
      title: "Risk Management",
      icon: Icons.security,
      description: "Protect your investments with proper risk management techniques",
      sections: [
        "Portfolio Diversification",
        "Stop-Loss Orders",
        "Risk-Reward Ratio",
        "Volatility and Beta"
      ],
    ),
    StockMarketTopic(
      title: "Regulations & Ethics",
      icon: Icons.gavel,
      description: "Laws, regulations, and ethical considerations in the market",
      sections: [
        "Regulatory Bodies",
        "Insider Trading Laws",
        "Market Manipulation",
        "ESG Investing"
      ],
    ),
    StockMarketTopic(
      title: "Algorithmic Trading",
      icon: Icons.computer,
      description: "Using algorithms and code to automate trading strategies",
      sections: [
        "Automated Systems",
        "High-Frequency Trading",
        "Python for Trading",
        "Backtesting"
      ],
    ),
    StockMarketTopic(
      title: "Real-Time Trading",
      icon: Icons.bolt,
      description: "Essential skills and tools for active trading",
      sections: [
        "Order Types",
        "Level 2 Data",
        "Liquidity & Slippage",
        "News-Based Trading"
      ],
    ),
    StockMarketTopic(
      title: "Advanced Topics",
      icon: Icons.auto_graph,
      description: "Cutting-edge concepts in modern financial markets",
      sections: [
        "Cryptocurrencies & Blockchain",
        "Behavioral Economics",
        "Global Market Correlations",
        "Dark Pools & HFT"
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,

            flexibleSpace: FlexibleSpaceBar(

              title: const Text(
                'Stock Market Mastery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://plus.unsplash.com/premium_photo-1681487767138-ddf2d67b35c1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Your Learning Journey',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // LinearProgressIndicator(
                  //   value: 0.35,
                  //   backgroundColor: Colors.grey[800],
                  //   valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                  // ),
                  // SizedBox(height: 4),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('35% Complete'),
                  //     Text('4 of 11 Topics'),
                  //   ],
                  // ),
                  SizedBox(height: 24),
                  Text(
                    'Learning Modules',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final topic = topics[index];
                  return TopicCard(topic: topic);
                },
                childCount: topics.length,
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   selectedItemColor: Theme.of(context).colorScheme.secondary,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: 0,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Learn'),
      //     BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      // ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final StockMarketTopic topic;

  const TopicCard({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopicDetailScreen(topic: topic),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  topic.icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    topic.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.library_books, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${topic.sections.length} sections',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicDetailScreen extends StatelessWidget {
  final StockMarketTopic topic;

  const TopicDetailScreen({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  Theme.of(context).colorScheme.primary.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(topic.icon, size: 48, color: Colors.white),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${topic.sections.length} sections • Estimated 2 hours',
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  topic.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start Learning',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Contents',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            topic.sections.length,
                (index) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Text('${index + 1}'),
                ),
                title: Text(topic.sections[index]),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learning Resources',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  ResourceItem(
                    title: 'Video Tutorials',
                    icon: Icons.video_library,
                    count: 5,
                  ),
                  Divider(),
                  ResourceItem(
                    title: 'Quizzes',
                    icon: Icons.quiz,
                    count: 3,
                  ),
                  Divider(),
                  ResourceItem(
                    title: 'Practice Exercises',
                    icon: Icons.assignment,
                    count: 7,
                  ),
                  Divider(),
                  ResourceItem(
                    title: 'PDF Downloads',
                    icon: Icons.file_download,
                    count: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResourceItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;

  const ResourceItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            '$count items',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}

class StockMarketTopic {
  final String title;
  final IconData icon;
  final String description;
  final List<String> sections;

  StockMarketTopic({
    required this.title,
    required this.icon,
    required this.description,
    required this.sections,
  });
}