CREATE DATABASE IF NOT EXISTS {{DBNAME}};

USE {{DBNAME}};

CREATE TABLE `administrators` (
  `admin_id` int(11) NOT NULL,
  `email` varchar(40) NOT NULL,
  `pword` varchar(40) NOT NULL,
  `regno` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `administrators`
--

INSERT INTO `administrators` (`admin_id`, `email`, `pword`, `regno`) VALUES
(1, 'admin@admin.com', 'admin', '2012224381');

-- --------------------------------------------------------

--
-- Table structure for table `poll`
--

CREATE TABLE `poll` (
  `poll_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question` varchar(200) NOT NULL,
  `poll_type` enum('Text','image') NOT NULL,
  `options` text NOT NULL,
  `link` text NOT NULL,
  `createdTime` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `poll`
--

INSERT INTO `poll` (`poll_id`, `user_id`, `question`, `poll_type`, `options`, `link`, `createdTime`, `status`) VALUES
(19, 1, 'For the president of Nacoss', 'image', 'a:2:{i:1;a:2:{s:5:\"photo\";s:39:\"assets/uploads/thumb/VTYJIenf_thumb.png\";s:4:\"name\";s:14:\"Benson Madison\";}i:2;a:2:{s:5:\"photo\";s:39:\"assets/uploads/thumb/RqF7KM3D_thumb.png\";s:4:\"name\";s:15:\"Uche theophilus\";}}', 'http://[::1]/ci_voting/poll/vote/1496599720', 1496599720, 1),
(20, 1, 'for the post of house captain', 'Text', 'a:2:{i:1;s:14:\"Savior savitor\";i:2;s:12:\"Barry allen \";}', 'http://[::1]/ci_voting/poll/vote/1496617858', 1496617858, 1),
(21, 1, 'For the position of NACOSS President 2017', 'image', 'a:3:{i:1;a:2:{s:5:\"photo\";s:39:\"assets/uploads/thumb/CIQFkR8z_thumb.jpg\";s:4:\"name\";s:12:\"Mr. Tony Eze\";}i:2;a:2:{s:5:\"photo\";s:39:\"assets/uploads/thumb/pVYGb3Pv_thumb.jpg\";s:4:\"name\";s:16:\"Mr. Francis Apuh\";}i:3;a:2:{s:5:\"photo\";s:39:\"assets/uploads/thumb/f3HA7w1W_thumb.jpg\";s:4:\"name\";s:19:\"Mr. Forever johnson\";}}', 'http://[::1]/ci_voting/poll/vote/1496734101', 1496734101, 1);

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `result_id` int(11) NOT NULL,
  `poll_id` int(11) NOT NULL,
  `results` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`result_id`, `poll_id`, `results`) VALUES
(5, 19, 'a:2:{i:1;i:60;i:2;i:36;}'),
(6, 20, 'a:2:{i:1;i:61;i:2;i:35;}'),
(7, 21, 'a:3:{i:1;i:104;i:2;i:77;i:3;i:30;}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `pword` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `lga` varchar(50) NOT NULL,
  `voters_id` varchar(50) NOT NULL,
  `can_vote` tinyint(1) NOT NULL DEFAULT '0',
  `regdate` int(11) NOT NULL,
  `dob` varchar(30) NOT NULL,
  `uniq_id` varchar(40) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `username`, `address`, `pword`, `state`, `lga`, `voters_id`, `can_vote`, `regdate`, `dob`, `uniq_id`, `email`, `phone`) VALUES
(1, 'sylva berry', 'admin', 'no 5 sage street nogeroa', 'admin', '1', '0', '1234567811', 0, 0, '', '', 'admin@admin.com', ''),
(2, 'sylva berry', 'sylvacoin', 'no 5 sage street nogeroa', '1234', 'Benue', 'Gboko', '1C5NIWSFZK23', 1, 0, '07/11/1995', '4HmFuOrqlYMaegA', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `vote_list`
--

CREATE TABLE `vote_list` (
  `vl_id` int(11) NOT NULL,
  `poll_id` int(11) NOT NULL,
  `vote_time` int(11) NOT NULL,
  `voter_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vote_list`
--

INSERT INTO `vote_list` (`vl_id`, `poll_id`, `vote_time`, `voter_id`) VALUES
(8, 21, 1496788564, 1),
(9, 19, 1499626211, 1),
(10, 20, 1499627576, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrators`
--
ALTER TABLE `administrators`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `regno` (`regno`);

--
-- Indexes for table `poll`
--
ALTER TABLE `poll`
  ADD PRIMARY KEY (`poll_id`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`result_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `voters_id` (`voters_id`),
  ADD UNIQUE KEY `uniq_id` (`uniq_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `vote_list`
--
ALTER TABLE `vote_list`
  ADD PRIMARY KEY (`vl_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrators`
--
ALTER TABLE `administrators`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `poll`
--
ALTER TABLE `poll`
  MODIFY `poll_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `result`
--
ALTER TABLE `result`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `vote_list`
--
ALTER TABLE `vote_list`
  MODIFY `vl_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
