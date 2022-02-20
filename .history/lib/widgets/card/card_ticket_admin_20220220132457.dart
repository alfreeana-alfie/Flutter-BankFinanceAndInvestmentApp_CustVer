import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/ticket.dart';
import 'package:flutter_banking_app/pages/admin/ticket/update_ticket_closed.dart';
import 'package:flutter_banking_app/pages/admin/ticket/update_ticket_operator.dart';
import 'package:flutter_banking_app/pages/admin/ticket/update_ticket_priority.dart';
import 'package:flutter_banking_app/pages/admin/ticket/update_ticket_status.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/detail.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CardTicketAdmin extends StatelessWidget {
  const CardTicketAdmin(
      {Key? key,
      required this.ticket,
      required this.ticketList,
      required this.index})
      : super(key: key);

  final Ticket ticket;
  final List<Ticket> ticketList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Values.horizontalValue,
          right: Values.horizontalValue,
        ),
        child: Card(
          elevation: 0.2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: Container(
                  color: Styles.thirdColor,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      iconColor: Styles.accentColor,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/payment_request.svg',
                              width: 30,
                              height: 30,
                              color: Styles.accentColor,
                            ),
                            const Gap(20),
                            Container(
                              constraints: const BoxConstraints(
                                  minWidth: 100, maxWidth: 220),
                              child: Text(
                                ticket.supportTicketId.toString(),
                                style: Theme.of(context).textTheme.headline6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                    collapsed: const Text(
                      '',
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var _ in Iterable.generate(5))
                          const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'const',
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Column(
                        children: [
                          Expandable(
                            collapsed: buildCollapsed1(),
                            expanded: buildExpanded1(context),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCollapsed1() {
    return Container(
      color: Styles.accentColor,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      Str.viewDetails,
                      style: Styles.cardTitle,
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  buildExpanded1(BuildContext context) {
    // Status
    String? status;
    switch (ticket.status) {
      case '0':
        status = 'NOT ACTIVE';
        break;
      case '1':
        status = 'ACTIVE';
        break;
      default:
        status = 'Default';
    }

    // Priority
    String? priority;
    switch (ticket.priority) {
      case '0':
        priority = 'Low';
        break;
      case '1':
        priority = 'Moderate';
        break;
      case '2':
        priority = 'High';
        break;
      default:
        priority = 'Default';
    }

    DateTime tempDate = DateTime.parse(ticket.createdAt ?? '-');
    String createdAt = DateFormat('yyyy-MM-dd hh:mm:ss').format(tempDate);

    return Container(
      color: Styles.accentColor,
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailRow(
              labelTitle: Str.subject,
              labelDetails: ticket.subject ?? Field.emptyString),
          DetailRow(
              labelTitle: Str.message,
              labelDetails: ticket.message ?? Field.emptyString),
          DetailRow(labelTitle: Str.status, labelDetails: status),
          DetailRow(labelTitle: Str.priority, labelDetails: priority),
          DetailRow(labelTitle: Str.created, labelDetails: createdAt),
          // _buildButtonRow(context),
          const Gap(20),
          ElevatedButton(
            onPressed: () {
              onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BranchLayout(
                    branch: branch,
                    type: Field.update,
                  ),
                ),
              );
            },
            },
            child: Text(
              Str.updateSupportTicketStatus.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateSupportTicketPriority(
                    ticket: ticket,
                  ),
                ),
              );
            },
            child: Text(
              Str.updateSupportTicketPriority.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateSupportTicketOperator(
                    ticket: ticket,
                  ),
                ),
              );
            },
            child: Text(
              Str.updateSupportTicketOperator.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateSupportTicketClosed(
                    ticket: ticket,
                  ),
                ),
              );
            },
            child: Text(
              Str.updateSupportTicketClosed.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
          ElevatedButton(
            onPressed: () {
              _showMyDialog(context);
            },
            child: Text(
              Str.delete.toUpperCase(),
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.dangerColor),
          ),
        ],
      ),
    );
  }

  _buildButtonRow(BuildContext context) {
    return ListView(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateSupportTicketStatus(
                    ticket: ticket,
                  ),
                ),
              );
            },
            child: Text(
              Str.edit.toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.successColor),
          ),
        ),
        const Gap(20),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _showMyDialog(context);
            },
            child: Text(
              Str.delete.toUpperCase(),
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Styles.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.0, primary: Styles.dangerColor),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Str.deleteConfirmation),
          content: Text(Str.areYouSure),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                Str.cancel.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0, primary: Styles.primaryColor),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                Str.delete.toUpperCase(),
                style: Theme.of(context).textTheme.button,
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0.0, primary: Styles.dangerColor),
            ),
          ],
        );
      },
    );
  }
}
