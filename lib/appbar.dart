import 'package:flutter/material.dart';

class Appbar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return _buildAppBar();
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽 아이콘
          Image.asset('assets/icon/bar.png', width: 21, height: 21,),

          // 가운데 로고
          Expanded(
            child: Center(
              child: Image.asset('assets/logo.png', height: 24),
            ),
          ),

          // 오른쪽 아이콘
          Image.asset('assets/icon/bell.png', height: 24),
        ],
      )
      ,
    );
  }

}