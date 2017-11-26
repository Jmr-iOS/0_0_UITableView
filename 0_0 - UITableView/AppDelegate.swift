/************************************************************************************************************************************/
/** @file       AppDelegate.swift
 *  @project    0_0 - UITableView
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/5/17
 *  @last rev   11/26/17
 *
 *
 *  @notes        x
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /********************************************************************************************************************************/
    /** @fcn    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:                         */
    /*                           [UIApplicationLaunchOptionsKey: Any]?) -> Bool                                                     */
    /*  @brief  return the elapsed time for the log AND active timer                                                                */
    /********************************************************************************************************************************/
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

