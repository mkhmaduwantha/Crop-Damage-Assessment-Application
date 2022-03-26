import 'package:crop_damage_assessment_app/components/loading.dart';
import 'package:crop_damage_assessment_app/models/claim.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ClaimView extends StatefulWidget {
  final Claim? claim;

  const ClaimView({Key? key, required this.claim}) : super(key: key);

  @override
  _ClaimProfileState createState() => _ClaimProfileState();
}

class _ClaimProfileState extends State<ClaimView> {
  bool loading = false;
  late List<dynamic> claim_image_urls_list = [];
  late List<Widget> imageSliders = [];

  void initClaimImages() async {
    setState(() {
      claim_image_urls_list = widget.claim!.claim_image_urls;
      imageSliders = widget.claim!.claim_image_urls.map((item) => 
          Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.fill, width: 2000.0, height: 1000),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${widget.claim!.claim_image_urls.indexOf(item) +1 } image',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

      loading = false;

    });
  }

  @override
  void initState() {

    super.initState();
    initClaimImages();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Column(
        children: <Widget>[

          const SizedBox(height: 20.0),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: 2,
              autoPlay: true,
            ),
            items: imageSliders,
          ),

          const SizedBox(height: 30.0),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              widget.claim!.claim_name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 32, 196, 100)),
            ),
          ),
          const SizedBox(height: 20.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Claim Details",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.claim!.description,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 80, 79, 79)),
            ),
          ),
          const SizedBox(height: 30.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Crop type - " +
                  widget.claim!.crop_type +
                  "\nReason for Damage - " +
                  widget.claim!.reason +
                  "\nAgrarian Division - " +
                  widget.claim!.agrarian_division +
                  "\nProvice - " +
                  widget.claim!.province +
                  "\nDate of Damage - " +
                  widget.claim!.damage_date +
                  "\nDamage Area - " +
                  widget.claim!.damage_area +
                  "\nEstimated Damage - " +
                  widget.claim!.estimate,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 80, 79, 79)),
            ),
          ),
        ],
      ),
    );
  }
}
