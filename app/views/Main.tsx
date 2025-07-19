import React from "react";
import Header from "./Header";
import Footer from "./Footer";
import SearchResults from "./SearchResults";

export default function Main() {
  return (
    <>
      <Header />
      <SearchResults />
      <main>
        <section className="video-section">
          <iframe
            width="100%"
            height="400"
            src="https://www.youtube.com/embed/ko7H70s7qq0" // Replace with your actual video URL
            title="Rubee Introduction"
            frameBorder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowFullScreen
          ></iframe>
        </section>
        <h2 id="why">Why Rubee?</h2>
        <div className="features">
          <div className="feature">
            <h3>Fast by default</h3>
            <p>A minimal footprint focused on serving Ruby applications efficiently</p>
          </div>
          <div className="feature">
            <h3>Modular</h3>
            <p> A modular approach to application development. Build modular monoliths with ease by attaching
as many subprojects as you need.</p>
          </div>
          <div className="feature">
            <h3>React-ready</h3>
            <p>React is inbuilt in Rubee, making it easy to build modern web applications</p>
          </div>
        </div>
      </main>
      <Footer />
    </>
  );
}
