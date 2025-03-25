import 'package:flutter/material.dart';

class InstrumentsContentScreen extends StatelessWidget {
  const InstrumentsContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Market Instruments'),
        backgroundColor: const Color(0xFF1E1E2C),
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
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSection(
            title: "Equities (Stocks)",
            content: """
Equities represent ownership in a company. When you purchase a stock, you're buying a small portion of the company, becoming a shareholder.

Types of stocks:
• Growth stocks: Companies expected to grow faster than average, often from emerging industries or innovative sectors. They typically don't pay dividends as profits are reinvested for expansion.

• Value stocks: Companies trading at lower prices relative to their fundamentals (earnings, dividends, etc.). These often come from established industries and frequently pay dividends.

Key characteristics:
• Ownership rights including voting at shareholder meetings
• Potential for capital appreciation
• Possibility of dividend income
• Higher risk but potentially higher returns than bonds
""",
            icon: Icons.trending_up,
            color: Colors.blueAccent,
          ),
          _buildSection(
            title: "Derivatives",
            content: """
Derivatives derive their value from underlying assets like stocks, bonds, commodities, currencies, interest rates, or market indexes.

Main types:
• Futures: Contracts to buy/sell assets at predetermined future dates and prices. Used for hedging or speculating on price movements.

• Options:
  - Call options: Give the holder the right (but not obligation) to buy an asset at a set price within a specific timeframe
  - Put options: Give the holder the right to sell an asset at a set price within a specific timeframe

• Swaps: Contracts to exchange cash flows based on different variables (interest rates, currencies)

Key characteristics:
• Leverage: Control large positions with relatively small amounts of capital
• Risk management: Used to hedge existing positions
• Speculation: Generate profits from price movements without owning the underlying asset
""",
            icon: Icons.show_chart,
            color: Colors.purpleAccent,
          ),
          _buildSection(
            title: "Bonds and Fixed-Income Securities",
            content: """
Bonds are debt instruments where investors lend money to entities (corporations, governments) for a specified period at a fixed or variable interest rate.

Types of bonds:
• Government bonds: Issued by national governments (Treasury bonds in the US)
• Municipal bonds: Issued by states, cities, or counties
• Corporate bonds: Issued by companies to raise capital
• Junk bonds: High-yield, higher-risk bonds from companies with lower credit ratings

Key characteristics:
• Regular interest payments (coupons)
• Principal repayment at maturity
• Generally lower risk than stocks
• Fixed income stream makes them popular for retirement planning
• Prices move inversely to interest rates
""",
            icon: Icons.attach_money,
            color: Colors.greenAccent,
          ),
          _buildSection(
            title: "Mutual Funds & ETFs",
            content: """
Pooled investment vehicles that collect money from multiple investors to purchase a diversified portfolio of securities.

Mutual Funds:
• Professionally managed investment funds
• Priced once daily at market close (NAV - Net Asset Value)
• May require minimum investments
• Can be actively or passively managed

Exchange-Traded Funds (ETFs):
• Trade like stocks throughout the day on exchanges
• Often have lower expense ratios than mutual funds
• Usually track specific indices (S&P 500, NASDAQ)
• Generally more tax-efficient than mutual funds

Benefits:
• Instant diversification
• Professional management
• Lower investment minimums than building your own diversified portfolio
• Various strategies (index tracking, sector-specific, asset allocation)
""",
            icon: Icons.pie_chart,
            color: Colors.orangeAccent,
          ),
          _buildSection(
            title: "Commodities & Forex",
            content: """
Commodities:
Physical goods traded on specialized exchanges. Major categories include:
• Energy: Crude oil, natural gas, gasoline
• Metals: Gold, silver, copper, platinum
• Agricultural: Corn, wheat, soybeans, coffee
• Livestock: Cattle, hogs

Trading methods:
• Futures contracts
• Options on futures
• ETFs and mutual funds
• Physical ownership (especially precious metals)

Forex (Foreign Exchange):
The global marketplace for trading national currencies against each other.
• Largest financial market in the world
• 24-hour trading 5 days a week
• Major currency pairs (EUR/USD, USD/JPY, GBP/USD)
• Typically traded in lots with significant leverage

Key characteristics:
• High liquidity
• Volatility influenced by economic data, geopolitics
• Used for hedging currency risk by multinational companies
""",
            icon: Icons.currency_exchange,
            color: Colors.amberAccent,
          ),
          const SizedBox(height: 30),
          _buildQuizSection(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E2C),
        selectedItemColor: const Color(0xFF00B894),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C5CE7),
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          // Navigate to next section
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFF4834DF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stock Market Instruments',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Understanding different investment vehicles',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoChip(Icons.access_time, '25 mins'),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.library_books, '5 sections'),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.bar_chart, 'Intermediate'),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(
            value: 0.4,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '40% complete',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                '2 of 5 sections',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF2D2D3A),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.white24),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.text_snippet, size: 18),
                      label: const Text('Example Case Study'),
                      style: TextButton.styleFrom(
                        foregroundColor: color,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF1E1E2C),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.quiz,
                  color: Color(0xFFFFA000),
                ),
                SizedBox(width: 8),
                Text(
                  'Knowledge Check',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Which of the following is NOT a characteristic of a bond?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildQuizOption(
              'Regular interest payments (coupons)',
              isSelected: false,
            ),
            _buildQuizOption(
              'Ownership rights in the company',
              isSelected: true,
            ),
            _buildQuizOption(
              'Principal repayment at maturity',
              isSelected: false,
            ),
            _buildQuizOption(
              'Fixed income stream for investors',
              isSelected: false,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF00B894).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF00B894)),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF00B894),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Correct! Bonds represent debt, not ownership. Ownership rights come with stocks/equities.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {},
                child: const Text('Continue to Next Question'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizOption(String text, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF00B894).withOpacity(0.2)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF00B894)
              : Colors.white.withOpacity(0.1),
        ),
      ),
      child: RadioListTile<bool>(
        title: Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xFF00B894) : Colors.white70,
          ),
        ),
        value: true,
        groupValue: isSelected,
        activeColor: const Color(0xFF00B894),
        onChanged: (value) {},
      ),
    );
  }
}