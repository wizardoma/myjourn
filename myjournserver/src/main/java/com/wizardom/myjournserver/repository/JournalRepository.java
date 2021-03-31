package com.wizardom.myjournserver.repository;

import com.wizardom.myjournserver.model.Journal;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JournalRepository extends JpaRepository<Journal, Long>  {

}
