import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taht_bety_provider/constants.dart';
import 'package:taht_bety_provider/features/home/presentation/view_model/cubit/update_provider_state_cubit.dart';

// فئة StatefulWidget للزر التبديل القابل للسحب لأن حالته ستتغير
class SlidingToggleSwitch extends StatefulWidget {
  const SlidingToggleSwitch({
    super.key,
    required this.providerId,
    required this.isOnline,
    required this.trackWidth,
    required this.isActive,
  });
  final String providerId;
  final bool isOnline;
  final double trackWidth;
  final bool isActive;
  @override
  _SlidingToggleSwitchState createState() => _SlidingToggleSwitchState();
}

// فئة الحالة لزر التبديل
class _SlidingToggleSwitchState extends State<SlidingToggleSwitch>
    with SingleTickerProviderStateMixin {
  late bool _isOnline; // الحالة الأولية: Offline (على اليمين)
  double _dragPosition = 1.0; // 0.0 لليسار (Online)، 1.0 لليمين (Offline)
  AnimationController? _animationController;
  Animation<double>? _animation;

  // أبعاد الزر والمقبض (المؤشر)
  late double _trackWidth; // العرض الكلي للمسار
  final double _trackHeight = 40.0; // ارتفاع المسار
  late double _thumbWidth; // عرض المقبض

  @override
  void initState() {
    super.initState();

    _isOnline = widget.isOnline;
    _dragPosition = _isOnline ? 1.0 : 0.0;
    // widget.isActive
    //     ? _dragPosition = _isOnline ? 0.0 : 1.0 // Online = 0.0, Offline = 1.0
    //     : _dragPosition = 1.0; // إذا لم يكن مفعل، يكون دائماً Offline
    _trackWidth = widget.trackWidth;
    _thumbWidth = widget.trackWidth / 2;
    // تهيئة وحدة التحكم بالرسوم المتحركة
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250), // مدة الرسوم المتحركة
    );
    // إعداد الرسوم المتحركة
    _animation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut);

    // إضافة مستمع للتحديثات لضمان إعادة بناء الواجهة
    _animation!.addListener(() {
      setState(() {
        _dragPosition = _animation!.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController?.dispose(); // التخلص من وحدة التحكم بالرسوم المتحركة
    super.dispose();
  }

  // معالجة بدء السحب الأفقي
  void _handleDragStart(DragStartDetails details) {
    _animationController?.stop(); // إيقاف أي رسوم متحركة جارية
  }

  // معالجة تحديث السحب الأفقي
  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      // حساب الموضع الجديد للمقبض بناءً على السحب
      // يتم قسمة دلتا السحب على المسافة التي يمكن أن يتحركها المقبض لتوحيدها بين 0 و 1
      _dragPosition =
          (_dragPosition - details.delta.dx / (_trackWidth - _thumbWidth))
              .clamp(0.0, 1.0);
    });
  }

  // معالجة انتهاء السحب الأفقي
  void _handleDragEnd(DragEndDetails details) {
    final double targetValue;
    // تحديد الحالة المستهدفة بناءً على سرعة السحب أو الموضع الحالي
    if (details.velocity.pixelsPerSecond.dx < -300) {
      // سحب سريع إلى اليسار (باتجاه Online)
      targetValue = 0.0;
    } else if (details.velocity.pixelsPerSecond.dx > 300) {
      // سحب سريع إلى اليمين (باتجاه Offline)
      targetValue = 1.0;
    } else {
      // إذا لم يكن هناك سحب سريع، استقر في أقرب حالة (أونلاين أو أوفلاين)
      targetValue = _dragPosition < 0.5 ? 0.0 : 1.0;
    }
    _animateTo(targetValue);
  }

  // معالجة النقر على الزر
  void _handleTap(bool isLogic) async {
    _animateTo(_isOnline ? 0.0 : 1.0); // تبديل الحالة
    if (isLogic) {
      await context
          .read<UpdateProviderStateCubit>()
          .updateProviderState(!_isOnline, widget.providerId);
    }
  }

  // // تشغيل الرسوم المتحركة إلى قيمة مستهدفة
  void _animateTo(double targetValue) {
    _animation = Tween<double>(
      begin: _dragPosition,
      end: targetValue,
    ).animate(_animationController!);

    _animationController!.forward(from: 0.0).then((_) {
      final newIsOnline = (targetValue == 1.0); // Online = 1.0

      // لو الحالة فعلاً اتغيرت، استدعي الدالة
      if (_isOnline != newIsOnline) {
        _isOnline = newIsOnline;
        // BlocProvider.of<UpdateProviderStateCubit>(context)
        //     .updateProviderState(_isOnline, widget.providerId);
      } else {
        _isOnline = newIsOnline;
      }

      setState(() {}); // علشان يعيد بناء الواجهة
    });
  }
  // تشغيل الرسوم المتحركة إلى قيمة مستهدفة
  // void _animateTo(double targetValue) {
  //   _animation = Tween<double>(begin: _dragPosition, end: targetValue)
  //       .animate(_animationController!);
  //   _animationController!.forward(from: 0.0).then((_) {
  //     // عند اكتمال الرسوم المتحركة، قم بتحديث الحالة المنطقية
  //     setState(() {
  //       _isOnline = (targetValue == 1.0);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // حساب موضع المقبض على طول المسار
    final double thumbPosition =
        (_trackWidth - _thumbWidth) * (1.0 - _dragPosition);

    // تحديد ألوان الخلفية والمقبض بناءً على الحالة
    // final Color backgroundColor = _isOnline
    //     ? Colors.green.shade700
    //     : Colors.grey.shade800; // أغمق قليلاً للخلفية
    final Color thumbColor =
        _isOnline ? ksecondryColor : kLightBlue; // ألوان المقبض

    return BlocListener<UpdateProviderStateCubit, UpdateProviderStateState>(
      listener: (context, state) {
        if (state is UpdateProviderStateFailure) {
          _handleTap(false);
        }
      },
      child: GestureDetector(
        // onHorizontalDragStart: _handleDragStart,
        // onHorizontalDragUpdate: _handleDragUpdate,
        // onHorizontalDragEnd: _handleDragEnd,
        onTap: widget.isActive
            ? () {
                _handleTap(true);
              }
            : null, // السماح بالنقر للتبديل أيضًا
        // () async {
        // await Future.delayed(const Duration(seconds: 2));

        // await context
        //     .read<UpdateProviderStateCubit>()
        //     .updateProviderState(_isOnline, widget.providerId);
        // },
        child: Container(
          width: _trackWidth,
          height: _trackHeight,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(_trackHeight / 2), // حواف دائرية للمسار
            // color: backgroundColor,
            border: Border.all(
              color: _isOnline ? ksecondryColor : kLightBlue, // لون الحدود
              width: 2.0, // سمك الحدود
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // نص "Online" على اليسار
              // Positioned(
              //   left: 20,
              //   child: Text(
              //     'Online',
              //     style: TextStyle(
              //       color: _isOnline
              //           ? Colors.white
              //           : Colors.grey
              //               .shade400, // لون أبيض عندما يكون Online، رمادي عند Offline
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // // نص "Offline" على اليمين
              // Positioned(
              //   right: 20,
              //   child: Text(
              //     'Offline',
              //     style: TextStyle(
              //       color: !_isOnline
              //           ? Colors.white
              //           : Colors.grey
              //               .shade400, // لون أبيض عندما يكون Offline، رمادي عند Online
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // المقبض المنزلق (الجزء المتحرك)
              AnimatedPositioned(
                duration: const Duration(
                    milliseconds:
                        0), // يتم التحكم في الحركة بواسطة الرسوم المتحركة وليس مدة الموضع المتحرك
                curve: Curves.easeInOut,
                left: _isOnline ? thumbPosition - 2 : thumbPosition - 8,
                child: Container(
                  width: _thumbWidth,
                  height: _trackHeight -
                      6, // أصغر قليلاً من الارتفاع الكلي لخلق تأثير "الداخل"
                  margin: const EdgeInsets.all(3.0), // هامش لتبدو داخل المسار
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (_trackHeight - 6) / 2), // حواف دائرية للمقبض
                    color: thumbColor,
                  ),
                  child: Center(
                    child: Text(
                      _isOnline ? 'Online' : 'Offline',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
