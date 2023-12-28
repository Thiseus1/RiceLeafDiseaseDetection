import 'package:flutter/material.dart';

class Disease {
  final String name;
  final String imageUrl;
  final String description;
  final String symptoms;
  final String treatment;

  Disease({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.symptoms,
    required this.treatment,
  });
}

List<Disease> diseaseList = [
  Disease(
    name: "Bacterial Leaf Blight",
    imageUrl: "assets/images/blf.png",
    description: "Bacterial disease of rice caused by Xanthomonas oryzae pv. oryzae; prevalent in both irrigated and rainfed conditions, particularly during the wet season.",
    symptoms: "- Kresek or wilting at seedling stage\n- Water-soaked to yellow-orange-striped lesionson the leaf blades and tips\n- Yellow-oranged bcterial ooze from lesions" ,
    treatment: "When symptoms are observed:\n\n- Drain and saturate the soil to reduce humidity.\n- Apply minimal nitrogen fertilizer or withhold further application.\n- Plow dry infected stubbles; dry the field after harvest.\n\nPreventive measures:\n\n- Use clean seeds of rresistant variety.\n- Reduce plant injury during transplanting\n- Avoid excessive nitrogen fertilization.\n- Remove weeds that serve as alternate hosts of the bacteria.",
  ),
  Disease(
    name: "Brownspot",
    imageUrl: "assets/images/brownspot.webp",
    description: "Brown spot has been historically largely ignored as one of the most common and most damaging rice diseases.\n\nBrown spot is a fungal disease that infects the coleoptile, leaves, leaf sheath, panicle branches, glumes, and spikelets. Its most observable damage is the numerous big spots on the leaves which can kill the whole leaf. When infection occurs in the seed, unfilled grains or spotted or discolored seeds are formed. ",
    symptoms: "Check for lesions:\n\n- Infected seedlings have small, circular, yellow brown or brown lesions that may girdle the coleoptile and distort primary and secondary leaves.\n- Starting at tillering stage, lesions can be observed on the leaves. They are initially small, circular, and dark brown to purple-brown.\n- Fully developed lesions are circular to oval with a light brown to gray center, surrounded by a reddish brown margin caused by the toxin produced by the fungi.\n\nOn susceptible varieties, lesions are 5−14 mm long which can cause leaves to wilt. On resistant varieties, the lesions are brown and pinhead-sized.\n\nLesions on leaf sheaths are similar to those on the leaves. Infected glumes and panicle branches have dark brown to black oval spots or discoloration on the entire surface.\n\nSpikelets can also be infected. Infection of florets leads to incomplete or disrupted grain filling and a reduction in grain quality. The disease-causing fungi can also penetrate grains, causing 'pecky rice', a term used to describe spotting and discoloration of grains.\n\nIn certain rice varieties, brown spot lesions can be mistaken for blast lesions. To confirm, check if spots are circular, brownish, and have a gray center surrounded by a reddish margin." ,
    treatment: "Improving soil fertility is the first step in managing brown spot. To do this:\n\n- Monitor soil nutrients regularly\n- Apply required fertilizers\n- For soils that are low in silicon, apply calcium silicate slag before planting\n\nFertilizers, however, can be costly and may take many cropping seasons before becoming effective. More economical management options include:\n\n- Use resistant varieties.\n Contact your local agriculture office for up-to-date lists of varieties available.\n- Use fungicides (e.g., iprodione, propiconazole, azoxystrobin, trifloxystrobin, and carbendazim) as seed treatments.\n- Treat seeds with hot water (53−54°C) for 10−12 minutes before planting, to control primary infection at the seedling stage. To increase effectiveness of treatment, pre-soak seeds in cold water for eight hours.",
  ),
  Disease(
    name: "Leaf Blast",
    imageUrl: "assets/images/riceblast.jpg",
    description: "Blast is caused by the fungus Magnaporthe oryzae. It can affect all above ground parts of a rice plant: leaf, collar, node, neck, parts of panicle, and sometimes leaf sheath.",
    symptoms: "Check the leaf and collar for lesions:\n\n- Initial symptoms appear as white to gray-green lesions or spots, with dark green borders.\n- Older lesions on the leaves are elliptical or spindle-shaped and whitish to gray centers with red to brownish or necrotic border.\n\nCheck for other symptoms:\n\n- Some resemble diamond shape, wide in the center and pointed toward either ends.\n- Lesions can enlarge and coalesce, growing together, to kill the entire leaves." ,
    treatment: "The primary control option for blast is to plant resistant varieties. Contact your local agriculture office for up-to-date lists of varieties available.\n\nOther crop management measures can also be done, such as:\n\n- Adjust planting time. Sow seeds early, when possible, after the onset of the rainy season.\n- Split nitrogen fertilizer application in two or more treatments. Excessive use of fertilizer can increase blast intensity.\n- Flood the field as often as possible.\n\nSilicon fertilizers (e.g., calcium silicate) can be applied to soils that are silicon deficient to reduce blast. However, because of its high cost, silicon should be applied efficiently. Cheap sources of silicon, such as straws of rice genotypes with high silicon content, can be an alternative. Care should be taken to ensure that the straw is free from blast as the fungus can survive on rice straw and the use of infected straw as a silicon source can spread the disease further.\n\nSystemic fungicides like triazoles and strobilurins can be used judiciously for control to control blast. A fungicide application at heading can be effective in controlling the disease.",
  ),
  Disease(
    name: "Tungro",
    imageUrl: "assets/images/tungro.JPG",
    description: "Caused by two different viruses: rice tungro bacilliform virus (RTBV) and rice tungro spherical virus (RTSV), efficiently carried by the green leafhopper (GLH), RTBV cannot be transmiitted by GLH unless RTSV is present.",
    symptoms: "- Mottled young leaves\n- Older leaves are yellow-orange\n- Stunted with slight reduction in tiller number" ,
    treatment: "When symptoms are observed:\n\n- Remove infected plants as soon as disease is detected\n\nPreventive natures:\n\n- Plant resistant variety.\n- Practice synchronous planting",
  ),
  Disease(
    name: "Hispa",
    imageUrl: "assets/images/hispa.jpg",
    description: "Rice hispa scrapes the upper surface of leaf blades leaving only the lower epidermis.\n\nIt also tunnels through the leaf tissues. When damage is severe, plants become less vigorous.",
    symptoms: "Check for feeding damage:\n\n- Scraping of the upper surface of the leaf blade leaving only the lower epidermis as white streaks parallel to the midrib\n- Irregular translucent white patches that are parallel to the leaf veins caused by tunneling of larvae through leaf tissue causes\n- Withering of damaged leaves\n- Whitish and membranous leaves\n\nRice field appears burnt when severely infested.\n\nHispa feeding damage is similar to feeding marks caused by flea beetles. To confirm cause of damage, check for insect presence, and the characteristic feeding marks:\n\n- Elongated, clear feeding marks\n- White streaks of uneaten lower epidermis between the parallel leaf veins" ,
    treatment: "A cultural control method that is recommended for the rice hispa is to avoid over fertilizing the field. Close plant spacing results in greater leaf densities that can tolerate higher hispa numbers. To prevent egg laying of the pests, the shoot tips can be cut. Clipping and burying shoots in the mud can reduce grub populations by 75−92%.\n\nAmong the biological control agents, there are small wasps that attack the eggs and larvae. A reduviid bug eats upon the adults. There are three fungal pathogens that attack the adults.",
  ),
  // Add more diseases here...
];

class DiseaseDetailScreen extends StatelessWidget {
  final Disease disease;

  const DiseaseDetailScreen({required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease.name),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  child: Image(
                    image: AssetImage(disease.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildSection("DESCRIPTION\n", disease.description, Colors.red),
              _buildSection("SYMPTOMS\n", disease.symptoms, Colors.blue),
              _buildSection("TREATMENT\n", disease.treatment, Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, Color color) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

