import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/home/models/job.dart';

class JobListTile extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobListTile({Key key, @required this.job,@required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Name:',style: Theme.of(context).textTheme.bodyText1),
                  Container(width: 10),
                  Text(job.name),
                ],
              ),
              Container(height: 20),
              Row(
                children: [
                  Text('Rate per hour:',style: Theme.of(context).textTheme.bodyText1),
                  Container(width: 10),
                  Text(job.ratePerHour.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
