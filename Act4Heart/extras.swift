//
//  extras.swift
//  Act4Heart
//
//  Created by Act4Heart on 13/04/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}

func pushNavigation(location: String) -> NSURLSessionTask {
    
    let url = "https://act4heart-act4heart.rhcloud.com/sendData"
    
    let timeInterval = NSDate().timeIntervalSince1970
    let params:[String: AnyObject] = ["user":user, "path":location, "unixtime":String(timeInterval)]
    
    let parameterString = params.stringFromHttpParameters()
    let requestURL = NSURL(string:"\(url)?\(parameterString)")!
    
    let request = NSMutableURLRequest(URL: requestURL)
    request.HTTPMethod = "GET"
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request)
    
    print("Sending navigational information " + location)
    
    task.resume()
    
    return task
    
}

// Design for rounded buttons
func roundedButton(button:UIButton) {
    button.layer.cornerRadius = 3
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.whiteColor().CGColor
    button.clipsToBounds = true
}

var symptomList = [
    "Ihållande bröstsmärta",
    "Obehagskänsla i bröstet",
    "Strålar i hals/käke/skuldra",
    "Illamående",
    "Andnöd",
    "Kallsvettning",
    "Rädsla och ångest",
    "Värk i ryggen",
    "Hjärtklappning och yrsel",
    "Influensaliknande besvär"
]

var symptoms = [
    "Hjärtinfarkt",
    "Vanliga symptom",
    "Vaga symptom kan också vara infarkt",
    "Bröstsmärtor kan vara annat än infarkt",
    "Riskfaktorer"
]

var symptomsInfo = [
    "\n\nVid en hjärtinfarkt kan en skada uppkomma som gör att hjärtat inte klarar att arbeta lika bra som innan. Hjärtinfarkt kan vara en livshotande sjukdom och kräver omedelbar sjukhusvård. Ju tidigare du får vård desto större är möjligheten att behandla och påverka hjärtinfarktens utveckling. \n\n Om du misstänker att någon i din närhet fått en hjärtinfarkt, ring 112. \n\nVid en akut hjärtinfarkt frisätts stresshormoner ut i blodbanan som leder till förhöjt blodtryck och snabbare hjärtrytm. Detta stressar hjärtat ytterligare och ökar den farliga syrebristen. Om du fått en hjärtinfarkt behöver kranskärlet som har täppts till av en blodpropp öppnas så snabbt som möjligt så att blodet kan passera normalt igen. Det kan ske med en så kallad ballongvidgning av kärlen eller med blodproppslösande medicin. Du får också behandling med andra typer av läkemedel efter utskrivningen. \n\nJu tidigare kärlet öppnas, desto större är chansen att blodflödet till hjärtmuskeln återställs och hjärtskadan minimeras. Om du bor i närheten av ett sjukhus som kan göra akut ballongvidgning brukar ambulansen köra direkt dit om EKG-bilden uppvisar ett särskilt mönster. Om du befinner dig mer än två timmar från ett sådant sjukhus kan du få propplösande medicin, som kan ges redan i hemmet eller i ambulansen av en sjuksköterska, som följt med.",
    "\n\n- Ihållande bröstsmärta \n\n- Obehagskänsla i bröstet\n\n - Strålande i hals, käkar eller skuldror\n\n- Illamående\n    - Viktigt att inte ta nitroglycerin om du är illamående \n\n - Andnöd\n\n - Kallsvettning\n\n- Rädsla och ångest\n\n- Värk i ryggen\n\n- Hjärtklappning och yrsel\n\n- Influensaliknande besvär",
    "\n\nOm du är äldre eller har diabetes och får hjärtinfarkt, är det inte säkert att du får ont i bröstet. Symtomen kan då vara diffusa, som andnöd eller stark trötthet. Smärtan kan vara mindre intensiv och kan misstolkas som mindre allvarlig.",
    "\n\nBröstsmärtor är en av de vanligaste anledningarna att söka akut sjukhusvård. Att du har ont i bröstet behöver inte betyda att du har ett hjärtproblem. De kan uppstå på grund av många andra orsaker, såsom:\n\nIrritation av slemhinnan i nedre delen av matstrupen\n\n- Sjukdomar i magsäck och gallblåseväggen\n\n- Sjukdomar i lungan\n\n- Besvär i bröstkorgen eller överkroppens muskler\n\n- Infektioner",
    "\n\nHjärt- och kärlsjukdomar är den vanligaste dödsorsaken i Sverige. Ungefär hälften av västvärldens befolkning insjuknar och dör i någon av dessa sjukdomar, där akut kranskärlssjukdom, alltså instabil kärlkramp och hjärtinfarkt, utgör en stor del.\n\nDet är känt att vissa typiska riskfaktorer ökar risken för att få hjärtinfarkt. De flesta av dessa kan du påverka med ändrade vanor. Risken ökar också med åldern\n\n- Sluta med rökning och annat tobaksbruk. Även om du redan har blivit sjuk finns stora hälsovinster med att sluta röka\n\n- Minska det skadliga kolesterolet (LDL) genom ändrad kost. Höga blodfetter ökar risken för att fååderförfettning, vilket i sin tur ökar risken för hjärtinfarkt\n\n- Håll din diabetessjukdom under kontroll, diabetes typ 1 eller diabetes typ 2. Två av tre personer som får en hjärtinfarkt har en försämrad omsättning av socker i kroppen.\n\n- Högt blodtryck ökar risken för hjärtinfarkt. Du kan ofta sänka blodtrycket med fysisk aktivitet eller läkemedel. \n\n- Motionera regelbundet. En daglig promenad på 30 minuter är bra motion för att minska risken för att få en kranskärlssjukdom."
]

