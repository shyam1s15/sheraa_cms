import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheraa_cms/bloc/app_bloc.dart';
import 'package:sheraa_cms/dto/order_dto.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key, required this.orderList});
  final List<OrderDetailDto> orderList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderList!.length > 0 ?
                Expanded(
                  child: ListView.separated(
                    itemCount: orderList.length,
                    itemBuilder: ((context, index) => OrderTile(
                          dto: orderList[index],
                        )),
                    separatorBuilder: ((context, index) =>
                        const Divider(height: 0)),
                  ),
                )
                : Container()
              ],
            ),
        );
  
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.dto});
  final OrderDetailDto dto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppBloc>(context)
            .add(LoadOrderDetailCmsEvent(dto.id ?? ""));
      },
      child: ListTile(
        leading: CircleAvatar(child: Text('A')),
        title: Text(dto.item?.name ?? ""),
        subtitle: Column(
          children: [
            Row(
              children: [
                    Text(
                      'customer name: (${dto.userName})',
                      style:
                          TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
              ],
            ),
            Row(
              children: [
                    SelectableText(
                      'customer phone (${dto.userPhone})',
                      style:
                          TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
              ],
            ),
            Row(
              children: [
                    SelectableText(
                      'Address: (${dto.userAddress})',
                      style:
                          TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
              ],
            ),
          ],
        ),
        trailing: InkWell(
          onTap: () async {
            // if (dto.userPhone != null && dto.userName!.length > 9) {
                bool passed = await launchPhoneCall(dto.userPhone!);
                if (!passed) {
                  _showErrorSnackBar(context, "could not launch phone call");
                }
            // }
          },
          child: Icon(Icons.phone)),
      ),
    );
  }

  Future<bool> launchPhoneCall(String phoneNumber) async {
  if (phoneNumber == null) return false;
  
  final url = Uri.parse('tel:$phoneNumber');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    return false;
  }
  return true;
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check, color: Colors.red),
                        SizedBox(width: 8),
                        Text(message),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
}

}
