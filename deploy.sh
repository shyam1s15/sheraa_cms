#!/bin/bash

# Run Flutter build web
flutter build web

# Deploy to Firebase
firebase deploy  --only hosting:cms-sheraa