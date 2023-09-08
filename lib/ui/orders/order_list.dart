import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheraa_cms/bloc/app_bloc.dart';
import 'package:sheraa_cms/dto/order_dto.dart';

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
        trailing: Icon(Icons.phone),
      ),
    );
  }
}
