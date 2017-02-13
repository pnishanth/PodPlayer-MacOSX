//
//  PodPlayerViewController.swift
//  PodPlay
//
//  Created by Nishanth P on 2/12/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Cocoa
import CoreData

class PodPlayerViewController: NSViewController, NSTableViewDelegate ,NSTableViewDataSource {
    
    @IBOutlet weak var podPlayUrlText: NSTextField!
    
    @IBOutlet weak var podTableView: NSTableView!
    
    var pods : [PodPlayer] = []
    
    @IBAction func addPod(_ sender: Any) {
        
        if let url = URL(string:podPlayUrlText.stringValue)
        {
            URLSession.shared.dataTask(with:url){ (data:Data?,response:URLResponse?, error) in
                
                if error != nil{
                    
                    print(error!)
                }
                    
                else
                    
                {
                    if data != nil{
                        let parser = Parse()
                       
                         let info = parser.getPodData(data: data!)
                        
                        if !self.podExists(resURl: self.podPlayUrlText.stringValue){
                    
                      if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext
                        
                        {
                            
                            let podcast = PodPlayer(context: context)
                                podcast.rssURL = self.podPlayUrlText.stringValue
                                podcast.imageURL = info.imageURL
                                podcast.title = info.title
                                
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
 
                            self.getPods()
                        }
                    }
                }
                }
            }.resume()
        }
    }
    
    func podExists(resURl:String) -> Bool {
        
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            
            let req =  PodPlayer.fetchRequest() as NSFetchRequest<PodPlayer>
            req.predicate = NSPredicate(format:"rssURL == %@",resURl)
            
            do{
                let matchPods = try context.fetch(req)
                if matchPods.count >= 1{
                    return true
                }
                else
                {
                    return false
                }
            }
            catch
            {
                print("Exception")
            }
          
        }
        
        return false
        
    }
    
    func getPods(){
        
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            
            let req =  PodPlayer.fetchRequest() as NSFetchRequest<PodPlayer>
            req.sortDescriptors = [NSSortDescriptor(key:"title",ascending:true)]
            do{
                pods = try context.fetch(req)
                print(pods)
            }
            catch
            {
                print("Exception")
            }
            DispatchQueue.main.async{
                
                self.podTableView.reloadData()
            }
        }
        
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return pods.count
        
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier:"podCell", owner:self) as? NSTableCellView
        
        let podplay = pods[row]
        if podplay.title != nil {
            cell?.textField?.stringValue = podplay.title!
        }
        else
        {
            cell?.textField?.stringValue = "No Title"
        }
            
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPods()
        
    }
    
}
