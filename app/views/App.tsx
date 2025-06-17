import React from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import "./../../css/app.css";
import Main from "./Main";

const NotFound = () => <h2>404 Not Found</h2>;

export function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  );
}

