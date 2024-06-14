import Vapor

func routes(_ app: Application) throws {
    // http://127.0.0.1:8080/
    app.get { req async in
        "It works!"
    }

    // http://127.0.0.1:8080/hello
    app.get("hello") { req async -> String in
        "Hello, world!" // returning String here, be clever for client-side programming.
    }
    
    // http://127.0.0.1:8080/films/action
    app.get("films", "action") { req async in
        "Action Films Believe That!!!"
    }
    
    // /movies/action
    // /movies/horror
    // /movies/kids
    // /movies/abc
    // route parameters/dynamic parameters
    app.get("movies", ":genre") { req async throws -> String in
        guard let genre = req.parameters.get("genre") else {
            throw Abort(.badRequest)
        }
        return "All movies of genre: \(genre)"
    }
    
    // /movies/action/2023
    app.get("movies", ":genre", ":year") { req async throws -> String in
        guard let genre = req.parameters.get("genre"),
              let year = req.parameters.get("year")
        else {
            throw Abort(.badRequest)
        }
        return "All movies of genre: \(genre) for year \(year)"
    }
    
    // customerId parameter must be Int , otherwise Error of ".badRequest" will be thrown.
    app.get("customer", ":customerId") { req async throws -> String in
        guard let customerId = req.parameters.get("customerId", as: Int.self) else {
            throw Abort(.badRequest)
        }
        return "\(customerId)"
    }
    
    // /hello-Sahil
    app.get("hello-Sahil") { req async in
        let str = "Hello Sahil, You can do it! Believe That!!!"
        return MyModel(dataString: str) // returning Object here, be clever for client-side programming.
    }
    
    var movieArr =  [
        Movie(title: "Shaktiman", year: 2023),
        Movie(title: "Krrish", year: 2024)
    ]
    
    // /movies
    app.get("movies") { req async in
        movieArr // returning Array of Object here, be clever for client-side programming.
    }
    
    
    // MARK: - Post

    app.post("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        movieArr.append(movie)
        app.get("movies") { req async in
            movieArr
        }
        return movie
    }
    
}
