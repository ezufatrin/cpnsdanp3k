import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({super.key, required this.title, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _progress = 0),
          onProgress: (p) => setState(() => _progress = p),
          onWebResourceError: (err) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal memuat halaman: ${err.description}'),
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<bool> _handleBack() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false; // jangan pop halaman, cukup back di WebView
    }
    return true; // boleh pop halaman
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: _handleBack,
      child: Scaffold(
        backgroundColor: cs.brightness == Brightness.light
            ? Colors.black
            : Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: cs.brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _controller.reload(),
              tooltip: 'Muat ulang',
            ),
          ],
        ),
        body: Column(
          children: [
            // progress bar tipis saat loading
            if (_progress < 100)
              LinearProgressIndicator(
                value: _progress / 100,
                minHeight: 2,
                color: cs.primary,
                backgroundColor: cs.surfaceVariant,
              ),
            Expanded(
              child: SafeArea(
                top: false,
                child: WebViewWidget(controller: _controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
