import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_bloc.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_event.dart';
import 'package:rlink_test/features/service_providers/bloc/service_providers_state.dart';
import 'package:rlink_test/features/service_providers/presentation/widgets/info_card.dart';
import 'package:rlink_test/features/service_providers/presentation/widgets/info_row.dart';
import 'package:rlink_test/src/di/services_locator.dart';
import 'package:rlink_test/src/themes/app_colors.dart';
import 'package:rlink_test/src/themes/app_theme.dart';

class ServiceProviderDetailScreen extends StatelessWidget {
  final int id;

  ServiceProviderDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (_) => sl.get<ServiceProviderBloc>()..add(FetchServiceProviderDetailsEvent(id: id)),
  child: BlocConsumer<ServiceProviderBloc, ServiceProviderState>(
  listener: (context, state) {

  },
  builder: (context, state) {
    var bloc = context.read<ServiceProviderBloc>();
    return Scaffold(
      body: (state.isLoading==true || bloc.serviceProviderDetailsModel==null)?
      const Center(child: CircularProgressIndicator(color: AppColors.primary,)):Column(
        children: [
          // Header with Gradient Background
          Container(
            height: 300.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:  BorderRadius.vertical(bottom: Radius.circular(30.r)),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 16.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      bloc.serviceProviderDetailsModel!.serviceProviders!.image ?? 'https://via.placeholder.com/150',
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 25.h,
                  left: 16.w,
                  child: Text(
                    bloc.serviceProviderDetailsModel!.serviceProviders!.name ?? 'Name here',
                    style: textTheme.displayMedium!.copyWith(color: AppColors.white),
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  right: 16.w,
                  child: Row(
                    children: [
                       Icon(
                        Icons.star,
                        color: AppColors.amber,
                        size: 30.0.h,
                      ),
                       SizedBox(width: 4.0.w),
                      Text(
                        '${bloc.serviceProviderDetailsModel!.serviceProviders!.rate?? 'Rate here'}',
                        style: textTheme.displayMedium!.copyWith(color: AppColors.white)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Body Section
          Expanded(
            child: SingleChildScrollView(
              padding:  REdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email and Phone
                  InfoCard(context: context, title: 'Contact Information', icon: Icons.contact_mail, children: [
                      InfoRow(icon: Icons.email, text: bloc.serviceProviderDetailsModel!.serviceProviders!.email?? 'Email here'),
                      InfoRow(icon: Icons.phone, text: bloc.serviceProviderDetailsModel!.serviceProviders!.phone ?? 'Phone here'),
                    ]),
                   SizedBox(height: 16.0.h),

                  // Description
                  InfoCard(context: context, title: 'Description', icon: Icons.description, children: [
                      Text(
                        bloc.serviceProviderDetailsModel!.serviceProviders!.description ?? 'Description here',
                        style: textTheme.bodyMedium,
                      ),
                    ]),
                   SizedBox(height: 16.0.h),

                  // Service Details
                  InfoCard(context: context, title: 'Service Details', icon: Icons.local_offer, children: [
                      InfoRow(icon: Icons.title, text: bloc.serviceProviderDetailsModel!.serviceProviders!.service!.title ?? 'Service Title here'),
                       SizedBox(height: 8.0.h),
                      Text(
                        bloc.serviceProviderDetailsModel!.serviceProviders!.service!.description?? 'Service Description here',
                        style: textTheme.bodyMedium,
                      ),
                    ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
),
);
  }



}




