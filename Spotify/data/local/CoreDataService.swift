//
//  CoreDataService.swift
//  Spotify
//
//  Created by VanDoang on 28/11/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    static var shared = CoreDataService()
    let managedContext: NSManagedObjectContext
    
    private init (){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    public func addSongToHistory (deezerTrack: DeezerTrack) {
        if songExists(deezerTrack.title) {
            print("Bài hát đã tồn tại trong lịch sử")
            return
        }
        
        let song = Song(context: managedContext)
        
        song.name = deezerTrack.title
        song.author = deezerTrack.artist.name
        song.img_url = deezerTrack.album.cover
        song.preview = deezerTrack.preview
        
        do {
            try managedContext.save()
            print("Đã lưu bài hát vào lịch sử: ", song.name)
            let allSongs = try managedContext.fetch(Song.fetchRequest())
            print("Bài hát trong DB:", allSongs.map { $0.name ?? "" })
            
        } catch let error as NSError {
            print("Không thể lưu bài hát vào local storage: ", error)
        }
    }
    
    func songExists(_ title: String) -> Bool {
        let fetch: NSFetchRequest<Song> = Song.fetchRequest()
        fetch.predicate = NSPredicate(format: "name == %@", title)
        return (try? managedContext.count(for: fetch)) ?? 0 > 0
    }
    
    func getHistory() -> [Song] {
        let fetch: NSFetchRequest<Song> = Song.fetchRequest()
        
        do {
            let songs = try managedContext.fetch(fetch)
            print("Fetched from CoreDataService:", songs.map { $0.name ?? "" })
            return songs
        } catch {
            print ("Không thể lấy bài hát từ history")
            return []
        }
    }

}
