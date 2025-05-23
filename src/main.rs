use actix_web::{web, App, HttpServer, Responder};

async fn hello() -> impl Responder {
    "Hello from Actix on Render!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().route("/", web::get().to(hello)))
        .bind("0.0.0.0:8080")?  // 👈 Must be 0.0.0.0
        .run()
        .await
}
