import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

const kPrimaryColor = Color(0xFFFFA69E);

const String databaseId = "64692227547132aeedee";

const String userCollectionId = "64692308b5f3ffa99674";

const String boardCollectionId = "64692faeb8fff7ce28a5";

const String taskCollectionId = "64692fa401613283e2ed";

const String tasksUsersCollectionId = "646b9f5cbf6ce684e006";

const String boardsUsersCollectionId = "646ba09569a2d1218bb7";

const String projectId = "6465ff3f354e6a2b9112";

const String endPoint = "https://cloud.appwrite.io/v1";

const String bucketsUsersProfilePictureId = "646b35f4cb0376ef7923";

Client client = Client().setEndpoint(endPoint).setProject(projectId);