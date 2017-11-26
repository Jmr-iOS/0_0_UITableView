/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - UITableView
 *  @brief      give example of use pf TableView, direct or through custom classes
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/5/17
 *  @last rev   11/26/17
 *
 *  @todo fix the fade transition in std remove to "fade to beneath the table"
 *
 *  @section    Ref
 *      http://viperxgames.blogspot.com/2014/11/add-uitableview-programmatically-in.html
 *      https://www.murage.ca/downcasting-in-swift-1-2-with-as-exclamation/
 *      http://www.tutorialspoint.com/ios/ios_ui_elements_tableview.htm
 *      (fade & slide) http://stackoverflow.com/questions/419472/have-a-reloaddata-for-a-uitableview-animate-when-changing
 *      (table re-ordering) http://swiftdeveloperblog.com/uitableviewcontroller-rearrange-or-reorder-table-cells-example-in-swift/
 *
 *  @section    Opens
 *      see what routines in this file pre-exist in subclasses and can be ignored
 *      Use UICustomTableViewHandler
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

enum Mode {
    case MODE_DIRECT;
    case MODE_CUSTOM;
    //...
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var verbose : Bool = false;

    let numItems_init  : Int = 16;
    
    let mode : Mode = .MODE_DIRECT;
    
    var items: [String]!;
    
    var tableView          : UITableView!;
    var customTable        : UICustomTableView!;
    var customTableHandler : UICustomTableViewHandler!;
    
    //options
    var cellBordersVisible : Bool = true;
    var usesCustomTiles    : Bool = true;
    
    //std table config
    let cellSelectionFade : Bool = true;


    /********************************************************************************************************************************/
    /** @fcn        override viewDidLoad()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;

        self.loadItems();
        
        switch(self.mode) {
            case .MODE_DIRECT:
                self.addStandardTable();
                break;
            case .MODE_CUSTOM:
                self.addCustomTable();
                break;
        }
        
        //Exit
        if(verbose){ print("ViewController.viewDidLoad():       viewDidLoad() complete"); }

        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        addCustomTable()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addCustomTable() {
    
        if(verbose){ print("ViewController.addCustomTable():      adding a custom table"); }
        
        customTable = UICustomTableView(frame:self.view.frame, style:UITableViewStyle.plain, items:items);

        //add the handler
        customTableHandler = UICustomTableViewHandler(items: items, timerTable: customTable);

        customTable.delegate   = customTableHandler;                                    /* Set both to handle clicks & provide data */
        customTable.dataSource = customTableHandler;
        
        //init the table
        customTable.separatorColor = (cellBordersVisible) ? UIColor.green : UIColor.clear;
        customTable.separatorStyle = (cellBordersVisible) ? .singleLine : .none;
        
        //Safety
        customTable.backgroundColor = UIColor.black;
        
        //Set the row height
        customTable.rowHeight = 75;
     
        if(verbose){ print("ViewController.addCustomTable():      it was shown"); }
        
        self.view.addSubview(customTable);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        addStandardTable()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addStandardTable() {

        if(verbose){ print("ViewController.addStandardTable():      adding a standard table"); }

        //Init
        tableView = UITableView(frame:self.view.frame);

        tableView.delegate = self;                                                              //Set both to handle clicks & provide data
        tableView.dataSource = self;

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");          //I have no idea why we do this
        tableView.translatesAutoresizingMaskIntoConstraints = false;                            //Std

        tableView.separatorColor = (cellBordersVisible) ? UIColor.green : UIColor.clear;
        tableView.separatorStyle = (cellBordersVisible) ? .singleLine : .none;

        //Safety
        tableView.backgroundColor = UIColor.black;

        //Set the row height
        tableView.rowHeight = 75;

        if(verbose){ print("ViewController.addStandardTable():      it was shown"); }

        //Add it!
        self.view.addSubview(tableView);

        return;
    }


/************************************************************************************************************************************/
/*                                                         Helpers                                                                  */
/************************************************************************************************************************************/
    
    
    /********************************************************************************************************************************/
    /** @fcn        loadItems()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func loadItems() {

        if(verbose){ print("ViewController.loadItems():    Items are loaded"); }
        
        self.items = [String]();
        
        for i in 0..<self.numItems_init {
            
            let charName : String = self.getCharName(i);
            
            self.items.append(self.getRowLabel(charName, index: i));
        }

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getCharName(_ i : Int) -> String
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getCharName(_ i : Int) -> String {
        return String(describing: UnicodeScalar(i + Int(("A" as UnicodeScalar).value)));
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getRowLabel(_ charName : String, index: Int) -> String
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getRowLabel(_ charName : String, index: Int) -> String {
        return String(format: "Item '%@' (%d)", charName, index);
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        addNewRow()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addNewRow() {
        
        let charName : String = self.getCharName(items.count);
        
        items.append(self.getRowLabel(charName, index: items.count));

        tableView.reloadData();
        
        print("row was added '\(items[items.count-1])'");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        removeLastRow(_ useFadeAndSlide : Bool)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func removeLastRow(_ useFadeAndSlide : Bool) {

        let lastRowIndex : Int = items.count-1;
        
        items.removeLast();

        if(useFadeAndSlide) {

            let transition = CATransition();
            
            transition.type = kCATransitionPush;
            
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);

            transition.fillMode = kCAFillModeForwards;
            
            transition.duration = 0.2;
            
            transition.subtype = kCATransitionFromTop;

            //grab row
            let lastRow : UITableViewCell = self.tableView.cellForRow(at: IndexPath(row: lastRowIndex, section: 0))!;

            lastRow.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey");
        }

        tableView.reloadData();

        return;
    }
    

/************************************************************************************************************************************/
/*                                    UITableViewDataSource, UITableViewDelegate Interfaces                                         */
/************************************************************************************************************************************/
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(verbose){ print("ViewController.tableView():         The table will now have \(items.count), cause I just said so..."); }
        
        return items.count;                                                         //return how many rows you want printed....!
    }

    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(verbose){ print("ViewController.tableView():         adding a cell"); }

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        let newTextValue:String = self.items[(indexPath as NSIndexPath).row];
        
        cell?.textLabel?.text = newTextValue;                                                   //text
        cell?.textLabel?.font = UIFont(name: (cell?.textLabel!.font.fontName)!, size: 20);      //font
        cell?.textLabel?.textAlignment = NSTextAlignment.center;                                //alignment
        
        
        if(self.cellSelectionFade == true) {
            cell?.selectionStyle = UITableViewCellSelectionStyle.gray;   //Options are 'Gray/Blue/Default/None'
        } else {
            cell?.selectionStyle = UITableViewCellSelectionStyle.none;
        }


        
        if(verbose){ print("'\(newTextValue)' was added to the table"); }
        
        return cell!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(verbose){ print("ViewController.tableView():         handling a cell tap of \((indexPath as NSIndexPath).item)"); }

        tableView.deselectRow(at: indexPath, animated:true);

        let currCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        if(verbose){ print("Hello Standard Cell at index \(indexPath)- '\(currCell.textLabel!.text!)'"); }

        
        
        /****************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                */
        /****************************************************************************************************************************/
        switch((indexPath as NSIndexPath).row) {
        case (0):
            print("top selected. Scrolling to the bottom!");
            tableView.scrollToRow(at: IndexPath(row: items.count-1, section: 0), at: UITableViewScrollPosition.bottom, animated: true);
            break;
        case (1):
            print("scrolling to the top with a Rect and no fade");
            tableView.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:false);          //immediate scroll to top
            break;
        case (2):
            print("scrolling to the top with scrollToRowAtIndexPath");
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true);
            break;
        case (3):
            print("adding a new row");
            self.addNewRow();
            break;
        case (4):
            print("removing last row");
            self.removeLastRow(true);
            break;
        case (self.items.count-2):
            print("turning on re-ordering");
            self.setReordering();
            break;
        case (self.items.count-1):
            print("scrolling to the top with a Rect and fade");
            tableView.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:true);           //slow scroll to top
            break;
        default:
            print("I didn't program a reaction for this case. I was lazy...");
            break;
        }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func setReordering()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setReordering() {

            for i in 0..<self.items.count {
                print("//->" + self.items[i]);
            }
            print(" ");

            self.tableView.setEditing(true, animated: true);

        return;
    }
    
    
//THE KEY
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        //you'll have to move it yourself as well
        let moved : String = self.items.remove(at: (sourceIndexPath as NSIndexPath).item);
        self.items.insert(moved, at: (destinationIndexPath as NSIndexPath).item);
        
        self.tableView.setEditing(false, animated: true);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none;            //If you say .Delete here it lets you delete too. .None is just reorder
    }
//END THE KEY

    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning(); }
}

