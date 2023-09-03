import 'package:firebase_app/service/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
 
class Appearance extends ConsumerStatefulWidget {
  const Appearance({super.key});
 
  @override
  ConsumerState<Appearance> createState() => _AppearanceState();
}
class _AppearanceState extends ConsumerState<Appearance> {

 
  @override
  Widget build(BuildContext context) {

    final night = ref.watch(themeProviderState) == ThemeMode.dark;
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Appearance',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(15),
                child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(30))

                ),
                child: ClipRRect(
                  child:Padding(padding:const EdgeInsets.only(top: 30, left: 20, bottom: 30),
                  
                    child : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Theme', style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Light'),
                        IconButton(
                          onPressed: (){
                            ref.read(themeProviderState.notifier).state = ThemeMode.light;
                          },
                           icon: Icon(night ?Icons.circle_outlined : Icons.circle_rounded))
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dark'),
                        IconButton(onPressed: (){
                          ref.read(themeProviderState.notifier).state = ThemeMode.dark;
                        }, 
                        icon: Icon(night ? Icons.circle_rounded : Icons.circle_outlined))
                      ]
                    ),
                    
                  ],
                ),
                )
                )
              )
              )
            )
          ],
        ),
      )
    );
  }
}