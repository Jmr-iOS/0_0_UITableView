//
//  AppDelegate.swift
//  0_0 - UITableView
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        
        self.window?.backgroundColor = UIColor.white;
        
        let viewController:ViewController = ViewController();
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false;
        
        self.window?.rootViewController = viewController;
        
        self.window?.makeKeyAndVisible();
        
        print("AppDelegate.application():     Application launch complete");
        
        return true;
    }

    func applicationWillResignActive(_ application: UIApplication)    { return;  }
    func applicationDidEnterBackground(_ application: UIApplication)  { return;  }
    func applicationWillEnterForeground(_ application: UIApplication) { return;  }
    func applicationDidBecomeActive(_ application: UIApplication)     { return;  }
    func applicationWillTerminate(_ application: UIApplication)       { return;  }
}

