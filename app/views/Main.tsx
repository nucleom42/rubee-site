import React from "react";
import Header from "./Header";
import Footer from "./Footer";

export default function Main() {
  return (
    <>
      <Header />
      <main>
        <h2 id="why">Why Rubee?</h2>
        <div className="features">
          <div className="feature">
            <h3>Fast by default</h3>
            <p>Fiber-based async system with minimal overhead.</p>
          </div>
          <div className="feature">
            <h3>Minimal yet Powerful</h3>
            <p>No configuration, just conventions and speed.</p>
          </div>
          <div className="feature">
            <h3>React-friendly</h3>
            <p>First-class React rendering support via ERB or JSX.</p>
          </div>
        </div>
      </main>
      <Footer />
    </>
  );
}
