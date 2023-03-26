import 'package:chat/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

class BubbleImage extends StatelessWidget {
  
  const BubbleImage(
      {super.key,
      this.message = '',
      this.time = '',
      this.delivered,
      this.isMe,
      this.isImage = false,
      this.url = '',
      this.status = ''});

  final String message, time, url, status;
  final delivered, isMe, isImage;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.white : MyColors.primaryColorLight;
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = status == 'ENVIADO'
        ? Icons.done
        : status == 'RECIBIDO'
            ? Icons.done_all
            : Icons.done_all;
    final radius = isMe
        ? const BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              right: isMe == true ? 3 : 70,
              left: isMe == true ? 70 : 3,
              top: 5,
              bottom: 5),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 22),
                child: isImage
                    ? FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/img/user_profile_2.png",
                        image: url)
                    : Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    const SizedBox(width: 3.0),
                    isMe == true
                        ? Icon(
                            icon,
                            size: 12.0,
                            color: status == 'VISTO'
                                ? Colors.blue
                                : Colors.black38,
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
