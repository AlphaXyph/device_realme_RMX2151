rm -rf packages/apps/RealmeParts
git clone https://github.com/Realme-G70-Series/android_packages_apps_RealmeParts.git -b aosp12 packages/apps/RealmeParts

rm -rf packages/apps/RealmeDirac
#git clone https://github.com/techyminati/android_packages_apps_RealmeDirac packages/apps/RealmeDirac


#ScreenRecording Fix
sed -i "134s/High/Main/" frameworks/base/packages/SystemUI/src/com/android/systemui/screenrecord/ScreenMediaRecorder.java
sed -i "134s/Level1/Level3/" frameworks/base/packages/SystemUI/src/com/android/systemui/screenrecord/ScreenMediaRecorder.java

#Cherry-pick some stuffs for A12
cd system/vold && git fetch https://github.com/ArrowOS/android_system_vold/ && cherry-pick 7a18da8f8a657c3bda9732bb3101aa252ac4a08a && cd ../..
cd external/selinux && git fetch https://github.com/ArrowOS/android_external_selinux/ && git cherry-pick I3d19545b4e50dc88179f5a7b2a30f827fe2955d2 && cd ../..
cd framework/base && git fetch https://github.com/PixelBlaster-Temp/frameworks_base/ && git cherry-pick 512d8394a00f09f531da70ce274dbdb1d71cd718 & cd ../..


