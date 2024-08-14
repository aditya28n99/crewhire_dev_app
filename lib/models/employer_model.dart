class Employer {
  final String employerId;
  final String companyName;
  final String aboutCompany;
  final String websiteLink;
  final Contact contact;
  final OfficeLocationAddress officeLocationAddress;
  final String industryType;
  final String since;
  final String typeOfCompany;
  final List<Award> awardsAndAchievemets;
  final SocialMediaHandles socialMediaHandles;
  final List<String> companyPhotos;

  Employer({
    required this.employerId,
    required this.companyName,
    required this.aboutCompany,
    required this.websiteLink,
    required this.contact,
    required this.officeLocationAddress,
    required this.industryType,
    required this.since,
    required this.typeOfCompany,
    required this.awardsAndAchievemets,
    required this.socialMediaHandles,
    required this.companyPhotos,
  });

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      employerId: json['employerId'] ?? '',
      companyName: json['companyName'] ?? '',
      aboutCompany: json['aboutCompany'] ?? '',
      websiteLink: json['websiteLink'] ?? '',
      contact: Contact.fromJson(json['contact'] ?? {}),
      officeLocationAddress:
          OfficeLocationAddress.fromJson(json['officeLocationAddress'] ?? {}),
      industryType: json['industryType'] ?? '',
      since: json['since'] ?? '',
      typeOfCompany: json['typeOfCompany'] ?? '',
      awardsAndAchievemets: (json['awardsAndAchievemets'] as List<dynamic>?)
              ?.map((item) => Award.fromJson(item))
              .toList() ??
          [],
      socialMediaHandles:
          SocialMediaHandles.fromJson(json['socialMediaHandles'] ?? {}),
      companyPhotos: (json['companyPhotos'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employerId': employerId,
      'companyName': companyName,
      'aboutCompany': aboutCompany,
      'websiteLink': websiteLink,
      'contact': contact.toJson(),
      'officeLocationAddress': officeLocationAddress.toJson(),
      'industryType': industryType,
      'since': since,
      'typeOfCompany': typeOfCompany,
      'awardsAndAchievemets':
          awardsAndAchievemets.map((item) => item.toJson()).toList(),
      'socialMediaHandles': socialMediaHandles.toJson(),
      'companyPhotos': companyPhotos,
    };
  }

  Employer copyWith({
    String? employerId,
    String? companyName,
    String? aboutCompany,
    String? websiteLink,
    Contact? contact,
    OfficeLocationAddress? officeLocationAddress,
    String? industryType,
    String? since,
    String? typeOfCompany,
    List<Award>? awardsAndAchievemets,
    SocialMediaHandles? socialMediaHandles,
    List<String>? companyPhotos,
  }) {
    return Employer(
      employerId: employerId ?? this.employerId,
      companyName: companyName ?? this.companyName,
      aboutCompany: aboutCompany ?? this.aboutCompany,
      websiteLink: websiteLink ?? this.websiteLink,
      contact: contact ?? this.contact,
      officeLocationAddress:
          officeLocationAddress ?? this.officeLocationAddress,
      industryType: industryType ?? this.industryType,
      since: since ?? this.since,
      typeOfCompany: typeOfCompany ?? this.typeOfCompany,
      awardsAndAchievemets: awardsAndAchievemets ?? this.awardsAndAchievemets,
      socialMediaHandles: socialMediaHandles ?? this.socialMediaHandles,
      companyPhotos: companyPhotos ?? this.companyPhotos,
    );
  }
}

class Contact {
  final String email;
  final String mobile;

  Contact({required this.email, required this.mobile});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'mobile': mobile,
    };
  }

  Contact copyWith({
    String? email,
    String? mobile,
  }) {
    return Contact(
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
    );
  }
}

class OfficeLocationAddress {
  final String address1;
  final String address2;
  final String pinCode;
  final String city;
  final String state;
  final String country;

  OfficeLocationAddress({
    required this.address1,
    required this.address2,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.country,
  });

  factory OfficeLocationAddress.fromJson(Map<String, dynamic> json) {
    return OfficeLocationAddress(
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      pinCode: json['pinCode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address1': address1,
      'address2': address2,
      'pinCode': pinCode,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  OfficeLocationAddress copyWith({
    String? address1,
    String? address2,
    String? pinCode,
    String? city,
    String? state,
    String? country,
  }) {
    return OfficeLocationAddress(
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      pinCode: pinCode ?? this.pinCode,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }
}

class Award {
  final String name;
  final String issuerOrOrganization;
  final String category;
  final String uploadImage;

  Award({
    required this.name,
    required this.issuerOrOrganization,
    required this.category,
    required this.uploadImage,
  });

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      name: json['name'] ?? '',
      issuerOrOrganization: json['issuerOrOrganization'] ?? '',
      category: json['category'] ?? '',
      uploadImage: json['uploadImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'issuerOrOrganization': issuerOrOrganization,
      'category': category,
      'uploadImage': uploadImage,
    };
  }

  Award copyWith({
    String? name,
    String? issuerOrOrganization,
    String? category,
    String? uploadImage,
  }) {
    return Award(
      name: name ?? this.name,
      issuerOrOrganization: issuerOrOrganization ?? this.issuerOrOrganization,
      category: category ?? this.category,
      uploadImage: uploadImage ?? this.uploadImage,
    );
  }
}

class SocialMediaHandles {
  final String youtube;
  final String instagram;
  final String facebook;
  final String twitter;
  final String linkedIn;

  SocialMediaHandles({
    required this.youtube,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.linkedIn,
  });

  factory SocialMediaHandles.fromJson(Map<String, dynamic> json) {
    return SocialMediaHandles(
      youtube: json['youtube'] ?? '',
      instagram: json['instagram'] ?? '',
      facebook: json['facebook'] ?? '',
      twitter: json['twitter'] ?? '',
      linkedIn: json['linkedIn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'youtube': youtube,
      'instagram': instagram,
      'facebook': facebook,
      'twitter': twitter,
      'linkedIn': linkedIn,
    };
  }

  SocialMediaHandles copyWith({
    String? youtube,
    String? instagram,
    String? facebook,
    String? twitter,
    String? linkedIn,
  }) {
    return SocialMediaHandles(
      youtube: youtube ?? this.youtube,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedIn: linkedIn ?? this.linkedIn,
    );
  }
}
