class AppFlavors {
  final String apiUrl;
  final String storageUrl;
  final String portalImagesUrl;

 /* AppFlavors.stg()
      : apiUrl = 'https://staging-api.thesigntracker.com/api/v1/',
        storageUrl = 'https://staging-api.thesigntracker.com/storage',
        portalImagesUrl = 'https://staging-api.thesigntracker.com/images';*/

  AppFlavors.prod()
      : apiUrl = 'https://api.thesigntracker.com/api/v1/',
        storageUrl = 'https://api.thesigntracker.com/storage',
        portalImagesUrl = 'https://portal.thesigntracker.com/images';


/*  AppFlavors.stg()
      : apiUrl = 'https://api.thesigntracker.com/api/v1/',
        storageUrl = 'https://api.thesigntracker.com/storage',
        portalImagesUrl = 'https://portal.thesigntracker.com/images';*/

/*  AppFlavors.prod()
      : apiUrl = 'https://api.thesigntracker.online/api/v1/',
        storageUrl = 'https://api.thesigntracker.online/storage',
        portalImagesUrl = 'https://portal.thesigntracker.com/images';*/

  AppFlavors.stg()
      : apiUrl = 'https://api.thesigntracker.online/api/v1/',
        storageUrl = 'https://api.thesigntracker.online/storage',
        portalImagesUrl = 'https://portal.thesigntracker.com/images';
}
