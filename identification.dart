import 'package:flutter/material.dart';
import 'package:myapp/transaction_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arushi App',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFC5C5), // Blush Pink
        scaffoldBackgroundColor: const Color(0xFFFFC5C5), // Blush Pink Background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE8A4A4), // Soft Pinkish
          foregroundColor: Colors.black, // Dark text/icons
          elevation: 0, // Flat look
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black, // Active tab text
          unselectedLabelColor: Colors.grey[700], // Inactive tab text
          indicatorColor: Colors.brown, // Active tab underline
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF5A2D2D)), // Dark Brown text
          bodyMedium: TextStyle(color: Color(0xFF5A2D2D)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFEDEDED), // Soft Gray Buttons
            foregroundColor: Color(0xFF5A2D2D), // Dark Brown text
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            elevation: 3, // Soft shadow effect
          ),
        ),
        cardColor: const Color(0xFFEDEDED), // Soft off-white for cards
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/mainMenu': (context) => const MainMenu(),
        '/quiz': (context) => const QuizScreen(),
        '/calculator': (context) => const CurrencyCalculator(),
        '/transaction':(context)=> const TransactionPage(),
      },
    );
  }
}






class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Arushi App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/mainMenu'),
              child: const Text('Go to App'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
              child: const Text('Currency Identification Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/calculator'),
              child: const Text('Currency Calculator'),
            ),
             const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/transaction'),
              child: const Text('Currency Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionData {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String imagePath;

  const QuestionData(this.question, this.options, this.correctAnswer, this.imagePath);
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _showFeedback = false;
  String _feedback = '';

  final List<QuestionData> _questions = [
    QuestionData('Identify the Coin', ['1 Rupee', '2 Rupees', '5 Rupees'], '1 Rupee', 'assets/1 coin.png'),
    QuestionData('Identify the Coin', ['1 Rupee', '2 Rupees', '5 Rupees'], '2 Rupees', 'assets/2 RS.png'),
    QuestionData('Identify the Coin', ['1 Rupee', '2 Rupees', '5 Rupees'], '5 Rupees', 'assets/5 coin.png'),
    QuestionData('Identify the Coin', ['5 Rupees', '10 Rupees', '20 Rupees'], '10 Rupees', 'assets/10 coin.png'),
    QuestionData('Identify the Coin', ['10 Rupees', '20 Rupees', '50 Rupees'], '20 Rupees', 'assets/20 coin.png'),
    QuestionData('Identify the Note', ['50 Rupees', '100 Rupees', '500 Rupees'], '100 Rupees', 'assets/WhatsApp Image 2025-03-28 at 20.55.07_967df8b8.jpg'),
    QuestionData('Identify the Note', ['200 Rupees', '500 Rupees', '2000 Rupees'], '500 Rupees', 'assets/500 note.png'),
    QuestionData('Identify the Note', ['200 Rupees', '500 Rupees', '2000 Rupees'], '200 Rupees', 'assets/200.jpg'),

  ];

  void _checkAnswer(String selectedAnswer) {
  setState(() {
    if (selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
      _feedback = 'Correct! 🎉';
      _score++;
    } else {
      _feedback = 'Wrong! ❌';
    }
    _showFeedback = true;
  });

  Future.delayed(const Duration(seconds: 1), () {
    if (mounted) {  // Ensures the widget is still available before updating state
      _nextQuestion();
    }
  });
}


  void _nextQuestion() {
  setState(() {
    _showFeedback = false; // Reset feedback visibility
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizResultScreen(score: _score, totalQuestions: _questions.length)),
      );
    }
  });
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Currency Quiz')),
    body: _showFeedback
        ? Center(
            child: Text(
              _feedback,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        : Center( // Centering the entire quiz content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Aligning children in center
              mainAxisSize: MainAxisSize.min, // Avoids extra space issues
              children: [
                Image.asset(
                  _questions[_currentQuestionIndex].imagePath,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                Text(
                  _questions[_currentQuestionIndex].question,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center, // Ensures text alignment
                ),
                const SizedBox(height: 20),
                ..._questions[_currentQuestionIndex].options.map(
                  (option) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => _checkAnswer(option),
                      child: Text(option),
                    ),
                  ),
                ),
              ],
            ),
          ),
  );
}

}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizResultScreen({super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your score: $score/$totalQuestions', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/mainMenu', (route) => false),
              child: const Text('Return to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrencyCalculator extends StatefulWidget {
  const CurrencyCalculator({super.key});

  @override
  _CurrencyCalculatorState createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  final TextEditingController _amount1Controller = TextEditingController();
  final TextEditingController _amount2Controller = TextEditingController();
  double _result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _amount1Controller, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount 1')),
            const SizedBox(height: 20),
            TextField(controller: _amount2Controller, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount 2')),
            ElevatedButton(
              onPressed: () => setState(() => _result = (double.tryParse(_amount1Controller.text) ?? 0) + (double.tryParse(_amount2Controller.text) ?? 0)),
              child: const Text('Calculate'),
            ),
            Text('Result: $_result'),
          ],
        ),
      ),
    );
  }
}
