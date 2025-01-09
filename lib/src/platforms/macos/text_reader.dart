import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class TextReader extends StatelessWidget {
  const TextReader({super.key});

  final String text = """
  <div class='container'>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eget commodo nulla. Ut sollicitudin, ligula at ultrices rhoncus, felis diam pretium ante, eu auctor arcu massa at metus. In ut tristique justo. Nulla commodo ultrices velit vel ultricies. Etiam nec velit purus. Etiam vehicula lectus ante, ac luctus eros aliquet non. Nullam faucibus vel risus nec sagittis. Phasellus sed finibus sem. Maecenas ultrices velit lorem, vel elementum mi commodo ac. Sed vel odio vitae nulla hendrerit eleifend. Praesent lacinia velit eget commodo faucibus.</p>

<p>Sed sed nunc libero. Sed semper facilisis mauris vitae tincidunt. Donec non pretium odio, sed feugiat nulla. Integer mauris ante, molestie et feugiat ut, porta at neque. Praesent eu enim ipsum. Donec urna neque, porta ac vulputate at, ullamcorper ut nibh. Nullam accumsan rhoncus ligula vel accumsan. Suspendisse et mi et libero placerat faucibus. Maecenas justo odio, tempor sit amet lacinia eget, ullamcorper vel ex. Aenean nunc ipsum, ultrices id arcu quis, euismod lacinia purus. In eget scelerisque risus. Nunc faucibus rhoncus porttitor. Fusce quam lorem, fringilla non tincidunt viverra, aliquet sed tortor.</p>

</div>
    """;

  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
        focusNode: FocusNode(),
        selectionControls: MaterialTextSelectionControls(),
        child: Row(children: [
          Expanded(
              child: Html(
            data: text,
            style: {
              "p": Style(
                fontSize: FontSize(16),
                color: Color(0xFF459999),
                fontFamily: 'Arial',
              ),
            },
          )),
          Expanded(
              child: Html(
            data: text,
            style: {
              "p": Style(
                fontSize: FontSize(16),
                color: Color(0xFF000000),
                fontFamily: 'Arial',
              ),
            },
          ))
        ]));
  }
}
