import 'package:backpackcheck/firebase/database.dart';
import 'package:backpackcheck/ui/drawer/app_drawer.dart';
import 'package:backpackcheck/ui/utils/router2.dart';
import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: const Text('Storage'),
          actions: const [
            SearchStorageButton(),
          ],
          bottom: const StorageScreenTabBar()),
      body: child,
    );
  }

// @override
// State<StorageScreen> createState() => _StorageScreenState();
}

class StorageScreenTabBar extends StatefulWidget implements PreferredSizeWidget {
  const StorageScreenTabBar({super.key});

  @override
  State<StorageScreenTabBar> createState() => _StorageScreenTabBarState();

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _StorageScreenTabBarState extends State<StorageScreenTabBar> with TickerProviderStateMixin<StorageScreenTabBar> {
  final List<Category> _categories = [];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
    _onTabChanged();
    Database.watchAddedCategories().listen((category) {
      setState(() {
        _categories.add(category);
        var currentIndex = _controller.index;
        _controller = TabController(initialIndex: currentIndex, length: _categories.length + 1, vsync: this);
        _onTabChanged();
      });
    });
    // extra listener to switch to the new category when it was created inside *this* app
    categoryAddedEvent.addListener(() {
      _controller.animateTo(_categories.indexWhere((category) => category.id == categoryAddedEvent.categoryId));
    });
    Database.watchRemovedCategories().listen((category) {
      setState(() {
        var currentIndex = _controller.index;
        var removedIndex = _categories.indexOf(category);
        _categories.remove(category);
        _controller = TabController(length: _categories.length + 1, vsync: this);
        _onTabChanged();
        if (currentIndex >= removedIndex) {
          currentIndex--;
          _controller.index = currentIndex;
        }
      });
    });
  }

  void _onTabChanged() {
    _controller.addListener(() {
      if (_controller.index == _controller.length - 1) {
        const NewCategoryRoute().navigate(context);
      } else {
        var categoryId = _categories[_controller.index].id;
        CategoryRoute(categoryId: categoryId).navigate(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: _controller,
      tabs: _categories
          .map(
            (category) => Tab(
              child: Text(category.name),
            ),
          )
          .cast<Widget>()
          .toList()
        ..add(const Tab(icon: Icon(Icons.add))),
    );
  }
}

class SearchStorageButton extends StatelessWidget {
  const SearchStorageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    );
  }
}
