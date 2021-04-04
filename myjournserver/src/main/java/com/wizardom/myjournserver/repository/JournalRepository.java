package com.wizardom.myjournserver.repository;

import com.wizardom.myjournserver.model.Journal;
import com.wizardom.myjournserver.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JournalRepository extends JpaRepository<Journal, Long>  {
 List<Journal> findByUser(User user);
}
